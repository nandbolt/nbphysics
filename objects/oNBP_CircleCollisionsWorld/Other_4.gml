/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	shape = NBPShape.CIRCLE;
	nbpAddContactGen(self.id, other.cgInst);
}