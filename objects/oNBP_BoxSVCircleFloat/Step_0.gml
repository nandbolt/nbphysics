// Triggers
var _inGravityWell = false;
for (var _i = 0; _i < array_length(triggers); _i++)
{
	if (triggers[_i].object_index == oNBP_Gravity)
	{
		// In gravity well
		_inGravityWell = true;
		grav.set(triggers[_i].x - x, triggers[_i].y - y);
		grav.normalize();
		grav.scale(20);
	}
}

// Gravity well
if (!_inGravityWell) grav.set(0, 20);