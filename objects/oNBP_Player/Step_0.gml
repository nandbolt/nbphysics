/// @desc Add Controller Force
nbpAddForce(self.id, moveInput.x * inverseMass, moveInput.y * inverseMass);

// Rotation
var _da = (mouse_wheel_up() - mouse_wheel_down()) * 5;
if (_da != 0)
{
	var _angle = image_angle + _da;
	nbpSetAngle(self.id, _angle);
	orientation.setRotation(-_angle);
}

// Shape change
if (mouse_check_button_pressed(mb_left))
{
	switch (shape)
	{
		case NBPShape.RECT:
			nbpSetShape(self.id, NBPShape.CIRCLE);
			break;
		case NBPShape.CIRCLE:
			nbpSetShape(self.id, NBPShape.RECT_ROTATED);
			break;
		case NBPShape.RECT_ROTATED:
			nbpSetShape(self.id, NBPShape.RECT);
			break;
	}
}