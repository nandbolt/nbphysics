/// @desc Link

// General
with (oNBP_RigidBody)
{
	nbpAddContactGen(self.id, other.cgInst);
}

// Boxes
with (oNBP_BoxSV)
{
	nbpAddTriggerGen(self.id, other.tgInst);
}

// Player
with (oNBP_PlayerSV)
{
	bounciness = 0;
	nbpSetShape(self.id, NBPShape.CIRCLE);
	nbpAddTriggerGen(self.id, other.tgInst);
}