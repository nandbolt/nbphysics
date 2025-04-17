// Inherit the parent event
event_inherited();

// Size
image_xscale = 36;
image_yscale = 3;

// Add wind force gen
nbpAddForceGen(self.id, oNBP_RainWorld.fgWind);

// Hide outlines
outlines = false;