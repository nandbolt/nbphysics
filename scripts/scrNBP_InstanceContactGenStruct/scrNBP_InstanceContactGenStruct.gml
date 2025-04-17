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
			
			// Check circle-circle collision
			if (_rb.shape == NBPShape.CIRCLE && _inst.shape == NBPShape.CIRCLE &&
				circleCircleCollision(_contact, _rb, _inst))
			{
				// Increment contacts
				_used++;
				_contactIdx++;
			}
			else if (_rb.shape == NBPShape.RECT && _inst.shape == NBPShape.RECT &&
				rectRectCollision(_contact, _rb, _inst))
			{
				// Increment contacts
				_used++;
				_contactIdx++;
			}
		}
		
		// Return contacts used
		return _used;
	}
	
	/// @func	circleCircleCollision(contact, c1, c2);
	///	@param	{Struct.Contact}	contact		The contact data.
	///	@param	{Id.Instance}		c1			The first circle.
	///	@param	{Id.Instance}		c2			The second circle.
	///	@desc	Returns whether or not there was a collision between two circles.
	static circleCircleCollision = function(_contact, _c1, _c2)
	{
		// Get distances
		var _dist = point_distance(_c1.x, _c1.y, _c2.x, _c2.y);  
		var _r1 = (_c1.bbox_right - _c1.bbox_left) * 0.5;
		var _r2 = (_c2.bbox_right - _c2.bbox_left) * 0.5;
		if (_dist < (_r1 + _r2))
		{
			// Clear contact
			_contact.clear();
		
			// Set rigid bodies
			_contact.rb1 = _c1;
			_contact.rb2 = _c2;
			
			// Normal
			_contact.normal.set(_c1.x - _c2.x, _c1.y - _c2.y);
			_contact.normal.normalize();
		
			// Penetration
			_contact.penetration = (_r1 + _r2) - _dist;
			return true;
		}
		return false;
	}
	
	/// @func	rectRectCollision(contact, r1, r2);
	///	@param	{Struct.Contact}	contact		The contact data.
	///	@param	{Id.Instance}		r1			The first rectangle.
	///	@param	{Id.Instance}		r2			The second rectangle.
	///	@desc	Returns whether or not there was a collision between two rectangles (non-rotating).
	static rectRectCollision = function(_contact, _r1, _r2)
	{
		// Clear contact
		_contact.clear();
		
		// Set rigid bodies
		_contact.rb1 = _r1;
		_contact.rb2 = _r2;
		
		// Get penetration depth
		var _dx = 0, _dy = 0;
		if (_r1.x < _r2.x) _dx = _r2.bbox_left - _r1.bbox_right;
		else _dx = _r2.bbox_right - _r1.bbox_left;
		if (_r1.y < _r2.y) _dy = _r2.bbox_top - _r1.bbox_bottom;
		else _dy = _r2.bbox_bottom - _r1.bbox_top;
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
}