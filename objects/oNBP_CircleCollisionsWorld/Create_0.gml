// Create physics world object
instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);

// Contact generator
cgInst = new InstContactGen();

// Circle boxes
var _px = 608, _py = 352;
leftBox = instance_create_layer(_px-128, _py, "Instances", oNBP_BoxTD);
rightBox = instance_create_layer(_px+128, _py, "Instances", oNBP_BoxTD);
topBox = instance_create_layer(_px, _py-128, "Instances", oNBP_BoxTD);
bottomBox = instance_create_layer(_px, _py+128, "Instances", oNBP_BoxTD);

// Show debugger
show_debug_overlay(true);