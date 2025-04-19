/// @desc Add Controller Force
moveInput.x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
moveInput.y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
moveInput.normalize();
moveInput.scale(moveStrength * inverseMass);
nbpAddForceVector(self.id, moveInput);

// Rotation
var _da = keyboard_check(vk_up) - keyboard_check(vk_down);
if (_da != 0)
{
	var _angle = image_angle + _da;
	nbpSetAngle(self.id, _angle);
	orientation.setRotation(-_angle);
}