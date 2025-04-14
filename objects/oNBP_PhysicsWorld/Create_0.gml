///	@desc	Init

/*
Holds and processes the physics world. You can generally house a physics world within any object,
but this one showcases what should be present to simulate it.
*/

// Physics
deltaTime = 1 / game_get_speed(gamespeed_fps);

// Bodies
rbObject = oNBP_RigidBody;