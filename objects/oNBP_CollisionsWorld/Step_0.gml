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