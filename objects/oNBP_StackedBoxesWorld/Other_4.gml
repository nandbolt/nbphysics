/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	shape = NBPShape.RECT;
	nbpAddContactGen(self.id, other.cgInst);
}