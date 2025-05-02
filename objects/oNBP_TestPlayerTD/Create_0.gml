// Inherit the parent event
event_inherited();

onTriggerEnter = function()
{
	nbpAddForce(self.id, 10000, 0);
}