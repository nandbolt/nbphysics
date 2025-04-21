// Shape
funcDrawShape(self.id);

// If asleep
if (!isAwake)
{
	// Sleep dot
	draw_set_color(c_fuchsia);
	draw_circle(x, y, 2, false);
	draw_set_color(c_white);
}