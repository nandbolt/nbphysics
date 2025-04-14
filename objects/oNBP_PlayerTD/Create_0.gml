// Inherit the parent event
event_inherited();

// Properties
damping = 0.25;

// Input
moveInput = new Vector2();
moveStrength = 20;

// Create spring force generator
var _fgSpring = new SpringForceGen(self.id, 1, 128);

// Set box sizes
with (oNBP_BoxTD)
{
	inverseMass = 0.125;
	damping = 0.25;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	nbpAddForceGen(self.id, _fgSpring);
}