// Inherit the parent event
event_inherited();

// Properties
damping = 0.25;

// Input
moveInput = new Vector2();
moveStrength = 20;

// Create 4 boxes
var _r = 128;
var _leftBox = instance_create_layer(x - _r, y, "Instances", oNBP_BoxTD);
var _rightBox = instance_create_layer(x + _r, y, "Instances", oNBP_BoxTD);
var _bottomBox = instance_create_layer(x, y - _r, "Instances", oNBP_BoxTD);
var _topBox = instance_create_layer(x, y + _r, "Instances", oNBP_BoxTD);

// Create spring force generator
var _fgSpring = new SpringForceGen(self.id, 1, _r);

// Set box sizes
with (oNBP_BoxTD)
{
	inverseMass = 0.125;
	damping = 0.25;
	image_xscale = other.image_xscale;
	image_yscale = other.image_yscale;
	nbpAddForceGen(self.id, _fgSpring);
}