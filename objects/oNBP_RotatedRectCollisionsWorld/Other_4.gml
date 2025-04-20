/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	nbpSetShape(self.id, NBPShape.RECT_ROTATED);
	nbpAddContactGen(self.id, other.cgInst);
}