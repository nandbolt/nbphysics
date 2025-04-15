// Create physics world object
instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);

// Link boxes to buoyancy force
fgBuoyancy = new BuoyancyForceGen(room_height * 0.75);