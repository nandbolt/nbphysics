// Update wind direction
fgWind.windForce.x = (mouse_x - room_width * 0.5) / room_width * 0.5 * 50;

// Add a drop to the simulation
repeat (8)
{
	var _x = random(room_width), _y = random_range(-64, -4);
	var _raindrop = instance_create_layer(_x, _y, "Instances", oNBP_Raindrop);
	with (pwRain)
	{
		// Add to physics world
		physicsWorld.addBody(_raindrop.rb);
	
		// Register forces
		physicsWorld.forceRegisty.addReg(_raindrop.rb, other.fgGravity);
		physicsWorld.forceRegisty.addReg(_raindrop.rb, other.fgWind);
	}
}