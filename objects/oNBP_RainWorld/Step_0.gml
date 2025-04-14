// Set simulation speed
if (mouse_check_button(mb_left)) oNBP_PhysicsWorld.simulationSpeed = 0.25;
else oNBP_PhysicsWorld.simulationSpeed = 1;

// Update wind direction
fgWind.windForce.x = (mouse_x - room_width * 0.5) / room_width * 0.5 * 50;

// Add a drop to the simulation
repeat (8 * oNBP_PhysicsWorld.simulationSpeed)
{
	var _x = random(room_width), _y = random_range(-64, -4);
	with (instance_create_layer(_x, _y, "Instances", oNBP_Raindrop))
	{
		// Gravity
		grav.y = 100;
		
		// Wind
		nbpAddForceGen(self.id, other.fgWind);
	}
}