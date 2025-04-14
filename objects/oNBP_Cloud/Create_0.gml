// Inherit the parent event
event_inherited();

// Color
var _c = random_range(100, 255);
image_blend = make_color_rgb(_c, _c, _c);

// Add wind force gen
nbpAddForceGen(self.id, oNBP_RainWorld.fgWind);