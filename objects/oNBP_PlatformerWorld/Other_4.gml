/// @desc Link

// General
with (oNBP_RigidBody)
{
	nbpAddContactGen(self.id, other.cgInst);
}

// Player
with (oNBP_PlayerSV)
{
	bounciness = 0;
	nbpSetShape(self.id, NBPShape.CIRCLE);
}