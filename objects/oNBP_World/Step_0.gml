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
else if (keyboard_check_pressed(vk_right)) GoToNextRoom();
else if (keyboard_check_pressed(vk_left)) GoToPreviousRoom();