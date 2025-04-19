/// @desc Add Controller Force
moveInput.x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
moveInput.y = keyboard_check(ord("S")) - keyboard_check(ord("W"));
moveInput.normalize();
moveInput.scale(moveStrength * inverseMass);
nbpAddForceVector(self.id, moveInput);

// Rotation
var _angle = image_angle + (keyboard_check(vk_up) - keyboard_check(vk_down));
nbpSetAngle(self.id, _angle);