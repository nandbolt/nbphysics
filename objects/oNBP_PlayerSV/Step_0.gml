/// @desc Add Controller Force
runInput = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _jump = 0;
if (keyboard_check_pressed(vk_space)) _jump = -50000;
nbpAddForce(self.id, runInput * inverseMass * moveStrength, _jump * inverseMass);