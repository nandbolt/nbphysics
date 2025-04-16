// Shape
switch (shape)
{
	case NBPShape.RECT:
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		break;
	case NBPShape.RECT_ROTATED:
		draw_self();
		break;
	case NBPShape.CIRCLE:
		draw_circle(x, y, (bbox_right - bbox_left) * 0.5, true);
		break;
}