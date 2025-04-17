/// @desc Link Contact Gen
var _i = 0;
with (oNBP_RigidBody)
{
	if (_i == 1) shape = NBPShape.RECT;
	else shape = NBPShape.CIRCLE;
	nbpAddContactGen(self.id, other.cgInst);
	_i = (_i + 1) % 2;
}