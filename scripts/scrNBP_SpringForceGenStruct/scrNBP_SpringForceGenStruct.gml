/// @func	SpringForceGen(rb, k, restLength);
///	@paran	{real}	rb			The rigid body.
///	@paran	{real}	k			The spring constant.
///	@paran	{real}	restLength	The rest length of the spring.
///	@desc	A force generator representing a spring.
function SpringForceGen(_rb, _k=1, _restLength=0) : ForceGen() constructor
{
	// Spring
	rb = _rb;
	k = _k;
	restLength = _restLength;
	
	///	@func	updateForce(rigidBody, dt);
	///	@param	{Struct.RigidBody}	rigidBody	The rigid body the force is being applied to.
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Applies the force to the body. Should be overwritten.
	static updateForce = function(_rb, _dt)
	{
		// Calculate force direction
		var _force = new Vector2(rb.x - _rb.x, rb.y - _rb.y);
		
		// Calculate magnitude
		var _len = _force.magnitude();
		var _dir = sign(_len - restLength);
		_len = abs(_len - restLength);
		_len *= k;
		
		// Apply final force
		_force.normalize();
		_force.scale(_len * _dir);
		nbpAddForceVector(_rb, _force);
	}
}