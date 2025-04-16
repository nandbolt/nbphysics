// Inherit the parent event
event_inherited();

// Create spring force generator
fgSpring = new SpringForceGen(self.id, 1, 128);

// Set box sizes
with (oNBP_BoxTD)
{
	nbpAddForceGen(self.id, other.fgSpring);
}

// Set bungee
fgBungee = new AnchoredBungeeForceGen(new Vector2(x, y), 1, 256);
nbpAddForceGen(self.id, fgBungee);