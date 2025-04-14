// Rotate
image_angle = velocity.angle();

// Destroy if not in view
if (bbox_top > room_height) instance_destroy();