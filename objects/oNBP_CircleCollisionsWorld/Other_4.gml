/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	nbpSetShape(self.id, NBPShape.CIRCLE);
	nbpAddContactGen(self.id, other.cgInst);
}