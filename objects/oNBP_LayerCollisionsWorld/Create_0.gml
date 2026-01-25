// Inherit the parent event
event_inherited();

// Name
name = "Layer Collisions";

// Contact generator
cgInst = new InstContactGen();

// Rotate
rotate = true;

///	@func	SetToRotatedRectLayer(rb);
SetToRotatedRectLayer = function(_rb)
{
	nbpSetLayers(_rb, true, 0, 1);
	nbpSetLayers(_rb, false, 0, 1);
}

///	@func	SetToRectLayer(rb);
SetToRectLayer = function(_rb)
{
	nbpSetLayers(_rb, true, 0, 0, 1);
	nbpSetLayers(_rb, false, 0, 0, 1);
}

///	@func	SetToCircleLayer(rb);
SetToCircleLayer = function(_rb)
{
	nbpSetLayers(_rb, true, 0, 0, 0, 1);
	nbpSetLayers(_rb, false, 0, 0, 0, 1);
}