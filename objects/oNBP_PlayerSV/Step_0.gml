/// @desc Set Move input
moveInput.x = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * moveStrength;
moveInput.y = 0;
if (keyboard_check_pressed(vk_space)) moveInput.y = -50000;

// Inherit the parent event
event_inherited();