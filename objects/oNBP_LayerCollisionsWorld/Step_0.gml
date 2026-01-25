// Inherit the parent event
event_inherited();

// Rotate some things
if (keyboard_check_pressed(vk_tab)) rotate = !rotate;
if (rotate)
{
	var _i = 0;
	with (oNBP_BoxTD)
	{
		if (_i == 0) nbpSetAngle(self.id, image_angle + 0.1);
		_i = (_i + 1) % 2;
	}
}

// Change layer
with (oNBP_PlayerTD)
{
	if (previousShape == shape) exit;
	previousShape = shape;
	switch (shape)
	{
		case NBPShape.CIRCLE:
			other.SetToCircleLayer(self.id);
			break;
		case NBPShape.RECT:
			other.SetToRectLayer(self.id);
			break;
		case NBPShape.RECT_ROTATED:
			other.SetToRotatedRectLayer(self.id);
			break;
	}
}