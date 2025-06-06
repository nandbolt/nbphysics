// Inherit the parent event
event_inherited();

// Name
name = "Springs";

// Collisions
cgInst = new InstContactGen();

// Anchored spring
var _px = 608, _py = 352;
fgLeftSpring = new AnchoredSpringForceGen(new Vector2(_px-128, _py));
leftBox = instance_create_layer(_px-128, _py, "Instances", oNBP_BoxTD);
nbpAddForceGen(leftBox, fgLeftSpring);
fgRightSpring = new AnchoredSpringForceGen(new Vector2(_px+128, _py));
rightBox = instance_create_layer(_px+128, _py, "Instances", oNBP_BoxTD);
nbpAddForceGen(rightBox, fgRightSpring);
fgTopSpring = new AnchoredSpringForceGen(new Vector2(_px, _py-128));
topBox = instance_create_layer(_px, _py-128, "Instances", oNBP_BoxTD);
nbpAddForceGen(topBox, fgTopSpring);
fgBottomSpring = new FakeSpringForceGen(new Vector2(_px, _py+128));
bottomBox = instance_create_layer(_px, _py+128, "Instances", oNBP_BoxTD);
nbpAddForceGen(bottomBox, fgBottomSpring);

// Boxes
with (oNBP_BoxTD)
{
	image_xscale = 9;
	image_yscale = 9;
}