/// @func	RigidBody(body, mass, damping);
///	@param	{Id.Instance}	body	The physical body/object.
///	@param	{real}	mass	The mass of the body (affects accelerations).
///	@param	{real}	damping	The damping force factor.
///	@desc	A rigid body that can be simulated in a physics world.
function RigidBody(_body=other.id, _mass=1, _damping=0.995) constructor
{
	// Physics world
	physicsWorld = undefined;
	
	// Body
	body = _body;
	inverseMass = 1 / _mass;
	
	// Movement
	velocity = new Vector2();
	acceleration = new Vector2();
	force = new Vector2();
	
	// Damping
	damping = _damping;
	
	#region Setters/Getters
	
	///	@func	getPosition();
	///	@return	{Struct.Vector2}	The body's position.	
	///	@desc	Returns the position of the rigid body.
	static getPosition = function(){ return new Vector2(body.x, body.y); }
	
	///	@func	setPosition(x, y);
	///	@param	{real}	x	The new x-coordinate.	
	///	@param	{real}	y	The new y-coordinate.	
	///	@desc	Sets the position of the rigid body.
	static setPosition = function(_x, _y)
	{
		body.x = _x;
		body.y = _y;
	}
	
	///	@func	setPositionVector(p);
	///	@param	{Struct.Vector2}	p	The new vector.
	///	@desc	Sets the position of the rigid body.
	static setPositionVector = function(_p)
	{
		body.x = _p.x;
		body.y = _p.y;
	}
	
	///	@func	getVelocity();
	///	@return	{Struct.Vector2}	The body's velocity.	
	///	@desc	Returns the velocity of the rigid body.
	static getVelocity = function(){ return new Vector2(velocity.x, velocity.y); }
	
	///	@func	setVelocity(vx, vy);
	///	@param	{real}	vx	The new velocity x-coordinate.	
	///	@param	{real}	vy	The new velocity y-coordinate.	
	///	@desc	Sets the velocity of the rigid body.
	static setVelocity = function(_vx, _vy)
	{
		velocity.x = _vx;
		velocity.y = _vy;
	}
	
	///	@func	setVelocityVector(v);
	///	@param	{Struct.Vector2}	v	The new velocity vector.
	///	@desc	Sets the velocity of the rigid body.
	static setVelocityVector = function(_v)
	{
		velocity.x = _v.x;
		velocity.y = _v.y;
	}
	
	///	@func	getAcceleration();
	///	@return	{Struct.Vector2}	The body's acceleration.	
	///	@desc	Returns the acceleration of the rigid body.
	static getAcceleration = function(){ return new Vector2(acceleration.x, acceleration.y); }
	
	///	@func	setAcceleration(ax, ay);
	///	@param	{real}	ax	The new acceleration x-coordinate.	
	///	@param	{real}	ay	The new acceleration y-coordinate.	
	///	@desc	Sets the acceleration of the rigid body.
	static setAcceleration = function(_ax, _ay)
	{
		acceleration.x = _ax;
		acceleration.y = _ay;
	}
	
	///	@func	setAccelerationVector(a);
	///	@param	{Struct.Vector2}	a	The new acceleration vector.
	///	@desc	Sets the acceleration of the rigid body.
	static setAccelerationVector = function(_a)
	{
		acceleration.x = _a.x;
		acceleration.y = _a.y;
	}
	
	///	@func	getMass();
	///	@return	{real}	The body's mass.	
	///	@desc	Returns the mass of the rigid body.
	static getMass = function()
	{
		if (inverseMass == 0) return infinity;
		return 1 / inverseMass;
	}
	
	///	@func	setMass(mass);
	///	@param	{real}	mass	The new mass.	
	///	@desc	Sets the mass of the rigid body.
	static setMass = function(_mass)
	{
		if (_mass == 0) throw("Set mass error. Mass can't be zero!");
		inverseMass = 1 / _mass;
	}
	
	///	@func	getInverseMass();
	///	@return	{real}	The body's inverse mass.	
	///	@desc	Returns the inverse mass of the rigid body.
	static getInverseMass = function(){ return inverseMass; }
	
	///	@func	setInverseMass(inverseMass);
	///	@param	{real}	inverseMass	The new inverse mass.	
	///	@desc	Sets the inverse mass of the rigid body.
	static setInverseMass = function(_inverseMass){ inverseMass = _inverseMass; }
	
	///	@func	getDamping();
	///	@return	{real}	The body's inverse mass.	
	///	@desc	Returns the inverse mass of the rigid body.
	static getDamping = function(){ return damping; }
	
	///	@func	setDamping(damping);
	///	@param	{real}	damping	The new damping.
	///	@desc	Sets the damping of the rigid body.
	static setDamping = function(_damping){ damping = _damping; }
	
	///	@func	getBody();
	///	@return	{Id.Instance}	The body object.	
	///	@desc	Returns the body object of the rigid body.
	static getBody = function(){ return body; }
	
	///	@func	setBody(body);
	///	@param	{real}	body	The new body.
	///	@desc	Sets the body object of the rigid body.
	static setBody = function(_body){ body = _body; }
	
	#endregion
	
	#region Properties
	
	///	@func	hasFiniteMass();
	///	@desc	Returns true if the body has finite mass, false if infinite (or immoveable).
	static hasFiniteMass = function(){ return inverseMass > 0; }
	
	#endregion
	
	#region Events
	
	///	@func	cleanup();
	///	@desc	Cleans up the data for the rigid body.
	static cleanup = function()
	{
		// Remove self from a physics world
		if (is_struct(physicsWorld)) physicsWorld.remove(self);
		
		// Vectors
		delete force;
		delete acceleration;
		delete velocity;
	}
	
	#endregion
	
	#region Simulation
	
	///	@func	clearForce();
	///	@desc	Clears the forces acting on the body.
	static clearForce = function(){ force.set(); }
	
	///	@func	addForce(fx, fy);
	///	@param	{real}	fx	The force x-coordinate to add.	
	///	@param	{real}	fy	The force y-coordinate to add.	
	///	@desc	Adds the force to the net force.
	static addForce = function(_fx, _fy){ force.add(_fx, _fy); }
	
	///	@func	addForceVector(f);
	///	@param	{Struct.Vector2}	fx	The force vector to add.	
	///	@desc	Adds the force to the net force.
	static addForceVector = function(_f){ force.addVector(_f); }
	
	///	@func	integrate(dt);
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Updates the body forward in time in the simulation. This means turning a
	///			net force -> acceleration -> velocity -> position.
	static integrate = function(_dt)
	{
		// Make sure time isn't zero
		if (_dt <= 0) throw("Integration error. Delta time can't be <= 0!");
		
		// Calculate acceleration
		acceleration.setScaledVector(force, inverseMass);
		
		// Calculate velocity
		velocity.addScaledVector(acceleration, _dt);
		
		// Apply velocity damping
		velocity.scale(power(damping, _dt));
		
		// Calculate position
		body.x += velocity.x;
		body.y += velocity.y;
		
		// Clear forces
		clearForce();
	}
	
	#endregion
}