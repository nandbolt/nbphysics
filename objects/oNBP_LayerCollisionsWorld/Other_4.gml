/// @desc Link Contact Gen
var _i = 0;
with (oNBP_RigidBody)
{
	if (_i == 0)
	{
		nbpSetShape(self.id, NBPShape.RECT_ROTATED);
		other.SetToRotatedRectLayer(self.id);
	}
	else if (_i == 1)
	{
		nbpSetShape(self.id, NBPShape.RECT);
		if (color != c_lime) color = c_yellow;
		other.SetToRectLayer(self.id);
	}
	else
	{
		nbpSetShape(self.id, NBPShape.CIRCLE);
		other.SetToCircleLayer(self.id);
	}
	nbpAddContactGen(self.id, other.cgInst);
	_i = (_i + 1) % 3;
}
with (oNBP_PlayerTD)
{
	color = c_aqua;
	previousShape = NBPShape.RECT_ROTATED;
	nbpSetShape(self.id, NBPShape.RECT_ROTATED);
	other.SetToRotatedRectLayer(self.id);
}