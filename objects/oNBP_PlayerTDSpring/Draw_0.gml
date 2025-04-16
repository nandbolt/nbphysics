// Inherit the parent event
event_inherited();

// Springs
with (oNBP_BoxTD)
{
	draw_line(other.x, other.y, x, y);
}

// Bungee
draw_line(x, y, fgBungee.anchor.x, fgBungee.anchor.y);