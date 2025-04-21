// Init player
with (oNBP_RigidBody)
{
	nbpAddContactGen(self.id, other.cgInst);
}
with (oNBP_PlayerTD)
{
	nbpSetShape(self.id, NBPShape.RECT);
}