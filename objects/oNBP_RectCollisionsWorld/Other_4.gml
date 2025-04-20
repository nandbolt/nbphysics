/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	nbpSetShape(self.id, NBPShape.RECT);
	nbpAddContactGen(self.id, other.cgInst);
}
with (oNBP_BoxTD)
{
	if (color != c_lime) color = c_yellow;
}