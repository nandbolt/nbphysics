// Create physics world object
pwRain = instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);

// Generators
fgGravity = new GravityForceGen();
fgWind = new WindForceGen();