// Inherit the parent event
event_inherited();

// Mouse push
if (mouse_check_button_released(mb_right))
{
	var _force = new Vector2(mouse_x - x, mouse_y - y);
	var _dist = _force.magnitude();
	var _forceMag = mousePushStrength * _dist;
	_force.normalize();
	_force.scale(_forceMag);
	nbpAddForceVector(self.id, _force);
	show_debug_message(string("force strength: {0}", _forceMag));
}