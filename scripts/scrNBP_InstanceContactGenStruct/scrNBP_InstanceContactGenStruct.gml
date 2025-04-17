///	@func	InstContactGen();
///	@desc	Handles contacts between instances (squares, rects, circles).
function InstContactGen() : ContactGen() constructor
{
	///	@func	addContact(rb, pw, limit);
	///	@param	{Id.Instance}	rb	The rigid body.
	///	@param	{Id.Instance}	pw	The physics world.
	///	@param	{real}	limit		The number of contacts that can be written to.
	///	@desc	Fills the contact structure with generated contacts.
	static addContact = function(_rb, _pw, _limit)
	{
		// Store contact count
		var _used = 0;
		
		// Check general collision
		var _placeMet = false;
		with (_rb)
		{
			_placeMet = place_meeting(x, y, _pw.rbObject);
		}
		if (_placeMet)
		{
			// Get instance
			var _inst = noone;
			with (_rb)
			{
				_inst = instance_place(x, y, _pw.rbObject);
			}
			if (!instance_exists(_inst)) return _used;
			
			// Get contact index
			var _contactIdx = _pw.nextContactIdx;
			
			// Get and clear contact
			var _contact = _pw.contacts[_contactIdx];
			
			// Check collision
			switch (_rb.shape)
			{
				case NBPShape.RECT:
					switch (_inst.shape)
					{
						case NBPShape.RECT:
							// RECT x RECT
							if (rectRectCollision(_contact, _rb, _inst))
							{
								_used++;
								_contactIdx++;
							}
							break;
						case NBPShape.CIRCLE:
							// RECT x CIRCLE
							if (circleRectCollision(_contact, _inst, _rb))
							{
								_used++;
								_contactIdx++;
							}
							break;
						case NBPShape.RECT_ROTATED:
							break;
					}
					break;
				case NBPShape.CIRCLE:
					switch (_inst.shape)
					{
						case NBPShape.RECT:
							// CIRCLE x RECT
							if (circleRectCollision(_contact, _rb, _inst))
							{
								_used++;
								_contactIdx++;
							}
							break;
						case NBPShape.CIRCLE:
							// CIRCLE x CIRCLE
							if (circleCircleCollision(_contact, _rb, _inst))
							{
								_used++;
								_contactIdx++;
							}
							break;
						case NBPShape.RECT_ROTATED:
							break;
					}
					break;
				case NBPShape.RECT_ROTATED:
					switch (_inst.shape)
					{
						case NBPShape.RECT:
							break;
						case NBPShape.CIRCLE:
							break;
						case NBPShape.RECT_ROTATED:
							break;
					}
					break;
			}
		}
		
		// Return contacts used
		return _used;
	}
	
	/// @func	circleCircleCollision(contact, circ1, circ2);
	///	@param	{Struct.Contact}	contact		The contact data.
	///	@param	{Id.Instance}		circ1		The first circle.
	///	@param	{Id.Instance}		circ2		The second circle.
	///	@desc	Returns whether or not there was a collision between two circles (and fills out the contact data).
	static circleCircleCollision = function(_contact, _circ1, _circ2)
	{
		// Get distances
		var _dist = point_distance(_circ1.x, _circ1.y, _circ2.x, _circ2.y);  
		var _r1 = nbpGetRadius(_circ1);
		var _r2 = nbpGetRadius(_circ2);
		if (_dist < (_r1 + _r2))
		{
			// Clear contact
			_contact.clear();
		
			// Set rigid bodies
			_contact.rb1 = _circ1;
			_contact.rb2 = _circ2;
			
			// Normal
			_contact.normal.set(_circ1.x - _circ2.x, _circ1.y - _circ2.y);
			_contact.normal.normalize();
		
			// Penetration
			_contact.penetration = (_r1 + _r2) - _dist;
			return true;
		}
		return false;
	}
	
	/// @func	rectRectCollision(contact, rect1, rect2);
	///	@param	{Struct.Contact}	contact		The contact data.
	///	@param	{Id.Instance}		rect1		The first rectangle.
	///	@param	{Id.Instance}		rect2		The second rectangle.
	///	@desc	Returns whether or not there was a collision between two non-rotating rectangles (and fills out the contact data).
	static rectRectCollision = function(_contact, _rect1, _rect2)
	{
		// Clear contact
		_contact.clear();
		
		// Set rigid bodies
		_contact.rb1 = _rect1;
		_contact.rb2 = _rect2;
		
		// Get penetration depth
		var _dx = 0, _dy = 0;
		if (_rect1.x < _rect2.x) _dx = _rect2.bbox_left - _rect1.bbox_right;
		else _dx = _rect2.bbox_right - _rect1.bbox_left;
		if (_rect1.y < _rect2.y) _dy = _rect2.bbox_top - _rect1.bbox_bottom;
		else _dy = _rect2.bbox_bottom - _rect1.bbox_top;
		if (abs(_dx) > abs(_dy)) _dx = 0;
		else _dy = 0;
		
		// Set collision normal direction
		_contact.normal.set(_dx, _dy);
		
		// Set penetration
		_contact.penetration = _contact.normal.magnitude();
		
		// Normalize normal
		_contact.normal.normalize();
		return true;
	}
	
	/// @func	circleRectCollision(contact, circ, rect);
	///	@param	{Struct.Contact}	contact		The contact data.
	///	@param	{Id.Instance}		circ		The circle.
	///	@param	{Id.Instance}		rect		The rectangle.
	///	@desc	Returns whether or not there was a collision between a circle and rectangle (and fills out the contact data).
	static circleRectCollision = function(_contact, _circ, _rect)
	{
		// Get distances
		var _r = nbpGetRadius(_circ);
		var _hw = (_rect.bbox_right - _rect.bbox_left) * 0.5, _hh = (_rect.bbox_bottom - _rect.bbox_top) * 0.5;
		var _cdx = abs(_circ.x - _rect.x), _cdy = abs(_circ.y - _rect.y);
		
		// Rectangle check
		if (_cdx > (_hw + _r)) return false;
		if (_cdy > (_hh + _r)) return false;
		
		// If vertical side hit
		if (_cdx <= _hw)
		{
			// Clear contact
			_contact.clear();
		
			// Set rigid bodies
			_contact.rb1 = _rect;
			_contact.rb2 = _circ;
			
			// Set collision normal direction
			var _dy = _rect.y - _circ.y;
			_contact.normal.set(0, _dy);
			_contact.normal.normalize();
			
			// Calculate penetration
			_contact.penetration = (_hh + _r) - abs(_dy);
			return true;
		}
		
		// If horizontal side hit
		if (_cdy <= _hh)
		{
			// HORIZONTAL SIDE HIT
			
			// Clear contact
			_contact.clear();
		
			// Set rigid bodies
			_contact.rb1 = _rect;
			_contact.rb2 = _circ;
			
			// Set collision normal direction
			var _dx = _rect.x - _circ.x;
			_contact.normal.set(_dx, 0);
			_contact.normal.normalize();
			
			// Calculate penetration
			_contact.penetration = (_hw + _r) - abs(_dx);
			return true;
		}
		
		// If corner hit
		var _cornerDistSquared = sqr(_cdx - _hw) + sqr(_cdy - _hh);
		if (_cornerDistSquared <= (_r * _r))
		{
			// Clear contact
			_contact.clear();
		
			// Set rigid bodies
			_contact.rb1 = _rect;
			_contact.rb2 = _circ;
			
			// Set collision normal direction
			var _dx = _rect.x - _circ.x, _dy = _rect.y - _circ.y;
			_contact.normal.set(_dx, _dy);
			_contact.normal.normalize();
			
			// Calculate penetration
			var _rdx = clamp(abs(_dx), 0, _hw) * sign(_dx), _rdy = clamp(abs(_dy), 0, _hh) * sign(_dy);
			_contact.penetration = _r - (sqrt(_dx * _dx + _dy * _dy) - sqrt(_rdx * _rdx + _rdy * _rdy));
			return true;
		}
		return false;
	}
}