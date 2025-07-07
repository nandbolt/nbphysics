// Inherit the parent event
event_inherited();

// Apply force
nbpSetAwake(self.id, true);
nbpSetShape(self.id, NBPShape.CIRCLE);
nbpAddForce(self.id, 400000, 0);