// Inherit the parent event
event_inherited();

// Cable
cgAnchoredCable = new AnchoredCableContactGen(
	new Vector2(x, y - 128), self.id, 128
);
nbpAddContactGen(self.id, cgAnchoredCable);