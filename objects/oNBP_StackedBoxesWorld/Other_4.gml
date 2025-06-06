/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	nbpSetShape(self.id, NBPShape.RECT);
	nbpAddContactGen(self.id, other.cgInst);
	bounciness = 0;
}
with (oNBP_BoxSV)
{
	bounciness = 1;
	
	// Wake
	nbpSetAwake(self.id, true);
}
with (oNBP_PlayerSV)
{
	bounciness = 0;
}