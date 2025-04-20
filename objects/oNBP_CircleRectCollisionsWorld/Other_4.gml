/// @desc Link Contact Gen
var _i = 0;
with (oNBP_RigidBody)
{
	if (_i == 1) nbpSetShape(self.id, NBPShape.RECT);
	else nbpSetShape(self.id, NBPShape.CIRCLE);
	nbpAddContactGen(self.id, other.cgInst);
	_i = (_i + 1) % 2;
}
with (oNBP_BoxTD)
{
	if (color != c_lime && shape == NBPShape.RECT) color = c_yellow;
}