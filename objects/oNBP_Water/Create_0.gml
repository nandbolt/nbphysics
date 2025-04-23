// Inherit the parent event
event_inherited();

// Shape
nbpSetShape(self.id, NBPShape.RECT_ROTATED);

// Water force
fgBuoyancy = new BuoyancyForceGen(bbox_top, 0.2);