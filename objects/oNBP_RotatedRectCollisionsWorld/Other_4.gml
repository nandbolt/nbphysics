/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	shape = NBPShape.RECT_ROTATED;
	nbpAddContactGen(self.id, other.cgInst);
}