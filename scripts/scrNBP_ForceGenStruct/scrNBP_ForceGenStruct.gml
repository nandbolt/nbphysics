/// @func	ForceGen();
///	@desc	Adds forces to 'registered' bodies. Only inherited force generators will be instanced.
function ForceGen() constructor
{
	///	@func	updateForce(rb, dt);
	///	@param	{Id.Instance}	rb	The rigid body.
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Applies the force to the body. Should be overwritten.
	static updateForce = function(_rb, _dt){}
}