// Inherit the parent event
event_inherited();

// Spring
fgAnchoredSpring = new AnchoredSpringForceGen(new Vector2(x, y - 128), 3);
nbpAddForceGen(self.id, fgAnchoredSpring);