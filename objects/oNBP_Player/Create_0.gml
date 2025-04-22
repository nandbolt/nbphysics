// Inherit the parent event
event_inherited();

// Properties
canSleep = false;
damping = 0.25;
inverseMass = 0.125;
bounciness = 0.5;

// Input
moveInput = new Vector2();
moveStrength = 1000;

///	@func	onTriggerEnter(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body enters the trigger.
onTriggerEnter = function(_trigger){ show_debug_message("Player entered trigger!"); }

///	@func	onTriggerExit(trigger);
///	@param	{Id.Instance}	trigger	The trigger.
///	@desc	Called once when the body exits the trigger.
onTriggerExit = function(_trigger){ show_debug_message("Player exited trigger!"); }