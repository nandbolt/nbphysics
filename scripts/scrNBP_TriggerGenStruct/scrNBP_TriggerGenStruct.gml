/// @func	TriggerGen();
///	@desc	Adds triggers to 'registered' bodies. Only inherited trigger generators will be instanced.
function TriggerGen() constructor
{
	name = "trigger gen";
	
	///	@func	trigger(rb, pw, dt);
	///	@param	{Id.Instance}	rb	The rigid body.
	///	@param	{Id.Instance}	pw	The physics world.
	///	@param	{real}	dt	The change in time of the simulation.
	///	@return	{Id.Instance}	The trigger that was triggered (or noone).
	///	@desc	Returns the trigger the rigid body triggered. Should be overwritten.
	static trigger = function(_rb, _pw, _dt){ return noone; }
	
	///	@func	toString();
	///	@desc	Returns the name of the trigger generator.
	static toString = function(){ return name; }
}