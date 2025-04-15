/// @func	Contact(rb1, rb2);
///	@param	{Id.Instance}	rb1	The first rigid body.
///	@param	{Id.Instance}	rb2	The second rigid body.
///	@desc	Holds contact data between two rigid bodies. Resolves through the removal of
///			interpenetration and then applying sufficient impulse to keep apart.
function Contact(_rb1, _rb2=undefined)
{
	rb1 = _rb1;					// The first body involved. Undefined == infinite mass/environment.
	rb2 = _rb2;					// The second body involved.
	restitution = 1;			// How quickly bodies separate (1 = bounce apart, 0 = stick together).
	normal = new Vector2();		// The contact normal from the perspective of the first body.
	penetration = 0;			// How much the bodies are intersecting.
	
	///	@func	resolve(dt);
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Resolves the contact, both for separating velocity and interpenetration.
	static resolve = function(_dt)
	{
		// Resolve
		resolveVelocity(_dt);
		resolveInterpenetration(_dt);
	}
	
	///	@func	calculateSeparatingVelocity();
	///	@return	{real}	The separating velocity.
	///	@desc	Returns the velocity magnitude required to separate the contact. Positive values mean
	///			the bodies are already separating, negative means otherwise.
	static calculateSeparatingVelocity = function()
	{
		// Get first body's velocity
		var _relativeVel = new Vector2(rb1.velocity.x, rb2.velocity.y);
		
		// Subtract second body's velocity if it exists
		if (instance_exists(rb2)) _relativeVel.add(-rb2.velocity.x, -rb2.velocity.y);
		
		// Return the dot product between relative velocity and normal
		return _relativeVel.dotProductVector(normal);
	}
	
	///	@func	resolveVelocity(dt);
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Handles impluses for the collision.
	static resolveVelocity = function(_dt)
	{
		// Get separating velocity
		var _sepVel = calculateSeparatingVelocity();
		
		// Return if no separating velocity (either separating or stationary - no impulse required!)
		if (_sepVel > 0) return;
		
		// Calculate new separating velocity
		var _newSepVel = -_sepVel * restitution;
		
		// Store if other rigid body exists
		var _rb2Exists = instance_exists(rb2);
		
		// Check velocity buildup due to acceleration
		var _accelCausedVel = new Vector2(rb1.acceleration.x, rb2.acceleration.y);
		if (_rb2Exists) _accelCausedVel.add(-rb2.acceleration.x, -rb2.acceleration.y);
		var _accelCausedSepVel = _accelCausedVel.dotProduct(normal.x * _dt, normal.y * _dt);
		
		// If closing velocity due to acceleration buildup
		if (_accelCausedSepVel < 0)
		{
			// Remove it from new separating velocity
			_newSepVel += _accelCausedSepVel * restitution;
			
			// Make sure we don't remove what wasn't there
			if (_newSepVel < 0) _newSepVel = 0;
		}
		
		// Get change in velocity
		var _deltaVel = _newSepVel - _sepVel;
		
		// Apply change in velocity propotional to inverse mass
		var _totalIMass = rb1.inverseMass;
		if (_rb2Exists) _totalIMass += rb2.inverseMass;
		
		// Return if infinite mass
		if (_totalIMass <= 0) return;
		
		// Calculate impulse
		var _impulse = _deltaVel / _totalIMass;
		
		// Calculate impulse per unit inverse mass
		var _impulsePerIMass = new Vector2(normal.x * _impulse, normal.y * _impulse);
		
		// Apply impulse to first body
		rb1.velocity.set(rb1.velocity.x + _impulsePerIMass.x * rb1.inverseMass,
			rb1.velocity.y + _impulsePerIMass.y * rb1.inverseMass);
		
		// Apply impulse to second body
		if (_rb2Exists)
		{
			rb2.velocity.set(rb2.velocity.x - _impulsePerIMass.x * rb2.inverseMass,
				rb2.velocity.y - _impulsePerIMass.y * rb2.inverseMass);
		}
	}
	
	///	@func	resolveInterpenetration(dt);
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Handles interpenetration resolution for the collision.
	static resolveInterpenetration = function(_dt)
	{
		// Return if no penetration
		if (penetration <= 0) return;
		
		// Store if the second rigid body is moveable
		var _rb2Moveable = false;
		if (instance_exists(rb2) && rb2.inverseMass > 0) _rb2Moveable = true;
		
		// Movement is based on inverse mass, so get total
		var _totalIMass = rb1.inverseMass;
		if (_rb2Moveable) _totalIMass += rb2.inverseMass;
		
		// Return if both infinite mass
		if (_totalIMass <= 0) return;
		
		// Find penetration per inverse mass
		var _movePerIMass = normal.getCopy();
		_movePerIMass.scale(penetration / _totalIMass);
		
		// Apply penetration resolution for first body
		rb1.set(rb1.x + _movePerIMass.x * rb1.inverseMass, rb1.y + _movePerIMass.y * rb1.inverseMass);
		if (_rb2Moveable) rb2.set(rb2.x - _movePerIMass.x * rb1.inverseMass, rb1.y - _movePerIMass.y * rb1.inverseMass);
	}
}

///	@func	ContactResolver(iterations);
///	@param	{real}	iterations	The number of iterations that can be used.
///	@desc	The contact resolution routine for contacts. Once can be shared for each physics world.
function ContactResolver(_iterations=1) constructor
{
	iterations = _iterations;
	iterationsUsed = 0;			// For performance testing
	
	///	@func	setIterations(iterations);
	///	@param	{real}	iterations	The number of iterations that can be used.
	///	@desc	Sets the iterations the resolver can use.
	static setIterations(_iterations){ iterations = _iterations; }
	
	///	@func	getIterationsUsed();
	///	@return	{real}	The number of iterations used.
	///	@desc	Gets the iterations used by the resolver.
	static getIterationsUsed = function(){ return iterationsUsed; }
	
	///	@func	resolveContacts(contacts, contactCount, dt);
	///	@param	{array}	contacts		All of the contacts that need resolving.
	///	@param	{real}	contactCount	How many contacts there are.
	///	@param	{real}	dt				The change in time in the simulation.
	///	@desc	Resolves contacts for both penetration and velocity.
	static resolveContacts = function(_contacts, _contactCount, _dt)
	{
		// Reset iterations used
		iterationsUsed = 0;
		
		// Iterate until done
		while (iterationsUsed < iterations)
		{
			// Find contact with largest closing velocity (opposite to separating)
			var _max = 0;
			var _maxIdx = _contactCount;
			for (var _i = 0; _i < _contactCount; _i++)
			{
				// Get separating velocity
				var _sepVel = _contacts[_i].calculateSeparatingVelocity();
				if (_sepVel < _max)
				{
					// Found new highest closing velocity
					_max = _sepVel;
					_maxIdx = _i;
				}
				
			}
			
			// Resolve this contact
			_contacts[_maxIdx].resolve(_dt);
			
			// Increment iterations used
			iterationsUsed++;
		}
	}
}