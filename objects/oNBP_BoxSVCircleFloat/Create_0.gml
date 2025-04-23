// Inherit the parent event
event_inherited();



///	@func	onTriggerEnter(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body enters the trigger.
onTriggerEnter = function(_trigger)
{
	switch (_trigger.object_index)
	{
		case oNBP_Water:
			show_debug_message("IN WATER");
			nbpAddForceGen(self.id, _trigger.fgBuoyancy);
			break;
	}
}

///	@func	onTriggerExit(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body exits the trigger.
onTriggerExit = function(_trigger)
{
	switch (_trigger.object_index)
	{
		case oNBP_Water:
			show_debug_message("OUT WATER");
			nbpRemoveForceGen(self.id, _trigger.fgBuoyancy);
			break;
	}
}