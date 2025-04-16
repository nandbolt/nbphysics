// Create physics world object
instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);

// Generators
fgWind = new WindForceGen();

// Show debugger
show_debug_overlay(true);