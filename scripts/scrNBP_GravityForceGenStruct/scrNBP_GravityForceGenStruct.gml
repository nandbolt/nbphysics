/// @func	GravityForceGen(fx, fy);
function GravityForceGen(_fx=0, _fy=100) : ForceGen() constructor
{
	// Gravity vector
	grav = new Vector2(_fx, _fy);
	
	///	@func	updateForce(rigidBody, dt);
	///	@param	{Struct.RigidBody}	rigidBody	The rigid body the force is being applied to.
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Applies the force to the body. Should be overwritten.
	static updateForce = function(_rb, _dt)
	{
		// Return if infinite mass
		if (!is_struct(_rb) || !_rb.hasFiniteMass()) return;
		
		// Apply gravity
		var _gravForce = grav.getScaled(_rb.getMass());
		_rb.addForceVector(_gravForce);
		delete _gravForce;
	}
}