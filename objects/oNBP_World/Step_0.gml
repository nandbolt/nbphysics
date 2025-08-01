// Set simulation speed
if (keyboard_check(vk_control)) oNBP_PhysicsWorld.simulationSpeed = 0.25;
else if (keyboard_check(vk_shift)) oNBP_PhysicsWorld.simulationSpeed = 2;
else oNBP_PhysicsWorld.simulationSpeed = 1;

// Fullscreen
if (keyboard_check_pressed(vk_f11))
{
	var _fullscreen = !window_get_fullscreen();
	window_set_fullscreen(_fullscreen);
	if (_fullscreen)
	{
		surface_resize(application_surface, display_get_width(), display_get_height());
		display_set_gui_size(display_get_width(), display_get_height());
	}
	else
	{
		surface_resize(application_surface, 1366, 768);
		display_set_gui_size(1366, 768);
	}
}

// Screenshots
if (keyboard_check_pressed(vk_f10)) screen_save("screenshot.png");

// Room changing
if (keyboard_check_pressed(ord("R"))) room_restart(); 
else if (keyboard_check_pressed(vk_right))
{
	var _room = rNBP_Water;
	if (room == rNBP_Rain) _room = rNBP_Spring;
	else if (room == rNBP_Spring) _room = rNBP_Water;
	else if (room == rNBP_Water) _room = rNBP_CircleCollisions;
	else if (room == rNBP_CircleCollisions) _room = rNBP_RectCollisions;
	else if (room == rNBP_RectCollisions) _room = rNBP_CircleRectCollisions;
	else if (room == rNBP_CircleRectCollisions) _room = rNBP_LinkCollisions;
	else if (room == rNBP_LinkCollisions) _room = rNBP_MoreLinkCollisions;
	else if (room == rNBP_MoreLinkCollisions) _room = rNBP_StackedBoxes;
	else if (room == rNBP_StackedBoxes) _room = rNBP_RotatedRectCollisions;
	else if (room == rNBP_RotatedRectCollisions) _room = rNBP_Collisions;
	else if (room == rNBP_Collisions) _room = rNBP_HighSpeedCollisions;
	else if (room == rNBP_HighSpeedCollisions) _room = rNBP_Platformer;
	else if (room == rNBP_Platformer) _room = rNBP_Rain;
	if (room_exists(_room)) room_goto(_room);
}
else if (keyboard_check_pressed(vk_left))
{
	var _room = rNBP_Water;
	if (room == rNBP_Rain) _room = rNBP_Platformer;
	else if (room == rNBP_Spring) _room = rNBP_Rain;
	else if (room == rNBP_Water) _room = rNBP_Spring;
	else if (room == rNBP_CircleCollisions) _room = rNBP_Water;
	else if (room == rNBP_RectCollisions) _room = rNBP_CircleCollisions;
	else if (room == rNBP_CircleRectCollisions) _room = rNBP_RectCollisions;
	else if (room == rNBP_LinkCollisions) _room = rNBP_CircleRectCollisions;
	else if (room == rNBP_MoreLinkCollisions) _room = rNBP_LinkCollisions;
	else if (room == rNBP_StackedBoxes) _room = rNBP_MoreLinkCollisions;
	else if (room == rNBP_RotatedRectCollisions) _room = rNBP_StackedBoxes;
	else if (room == rNBP_Collisions) _room = rNBP_RotatedRectCollisions;
	else if (room == rNBP_HighSpeedCollisions) _room = rNBP_Collisions;
	else if (room == rNBP_Platformer) _room = rNBP_HighSpeedCollisions;
	if (room_exists(_room)) room_goto(_room);
}