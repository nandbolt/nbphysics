// Body
inverseMass = 1;
shape = NBPShape.RECT_ROTATED;
bounciness = 1;
orientation = new Matrix22(-image_angle);
	
// Movement
velocity = new Vector2();
acceleration = new Vector2();
force = new Vector2();
prevForce = new Vector2();

// Gravity
grav = new Vector2();

// Damping
damping = 0.995;

// Physics generators
forceGens = [];
contactGens = [];

// Draw
color = c_white;
outlines = true;