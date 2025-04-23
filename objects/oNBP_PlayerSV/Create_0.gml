// Inherit the parent event
event_inherited();

// Properties
grav.y = 20;

// Jump
jumpDir = new Vector2(0, -1);
jumpBufferAmount = 10;
jumpBuffer = 0;
coyoteBufferAmount = 10;
coyoteBuffer = 0;
groundBufferAmount = 3;
groundBuffer = 0;
groundNormal = new Vector2(0, -1);

///	@func	onTriggerEnter(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body enters the trigger.
onTriggerEnter = function(_trigger)
{
	show_debug_message("Player entered trigger!");
	switch (_trigger.object_index)
	{
		case oNBP_Water:
			nbpAddForceGen(self.id, _trigger.fgBuoyancy);
			break;
	}
}

///	@func	onTriggerExit(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body exits the trigger.
onTriggerExit = function(_trigger)
{
	show_debug_message("Player exited trigger!");
	switch (_trigger.object_index)
	{
		case oNBP_Water:
			nbpRemoveForceGen(self.id, _trigger.fgBuoyancy);
			break;
	}
}