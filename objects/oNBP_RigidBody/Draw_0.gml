// Shape
switch (shape)
{
	case NBPShape.RECT:
		// Outlines
		if (outlines)
		{
			image_blend = c_dkgray;
			draw_set_color(c_dkgray);
			draw_self();
			draw_circle(x, y, nbpGetRadius(self.id), true);
		}
		
		// Rectangle
		draw_set_color(color);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		break;
	case NBPShape.RECT_ROTATED:
		// Outlines
		if (outlines)
		{
			draw_set_color(c_dkgray);
			draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
			draw_circle(x, y, nbpGetRadius(self.id), true);
		}
		
		// Rotated rectangle
		image_blend = color;
		draw_self();
		break;
	case NBPShape.CIRCLE:
		// Outlines
		if (outlines)
		{
			image_blend = c_dkgray;
			draw_set_color(c_dkgray);
			draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
			draw_self();
		}
		
		// Circle
		draw_set_color(color);
		draw_circle(x, y, nbpGetRadius(self.id), true);
		break;
}
draw_set_color(c_white);