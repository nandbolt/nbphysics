/// @func	PhysicsWorld(maxContacts, iterations);
///	@param	{real}	maxContacts	The max amount of contacts that can exist per step.
///	@param	{real}	iterations	The amount of iterations the contact resolver can
///								do per step.
///	@desc	Houses and runs a physics simulation.
function PhysicsWorld(_maxContacts=32, _iterations=64) constructor
{
	#region Events
	
	///	@func	cleanup();
	///	@desc	Cleans up data within a physics world.
	static cleanup = function(){}
	
	#endregion
	
	#region Helper
	
	///	@func	remove(body);
	///	@param	{Struct.RigidBody}	rb	The body to remove.
	///	@desc	Removes the given body from the rigid body if it exists within the world.
	static remove = function(_body){}
	
	#endregion
}