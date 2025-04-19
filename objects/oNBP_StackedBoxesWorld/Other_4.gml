/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	shape = NBPShape.RECT;
	nbpAddContactGen(self.id, other.cgInst);
	bounciness = 0;
}
with (oNBP_BoxSV)
{
	bounciness = 1;
}
with (oNBP_PlayerSV)
{
	bounciness = 0;
}