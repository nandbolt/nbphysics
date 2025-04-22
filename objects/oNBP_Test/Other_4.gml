/// @desc Link Contact Gen
with (oNBP_RigidBody)
{
	nbpSetShape(self.id, NBPShape.RECT_ROTATED);
	nbpAddContactGen(self.id, other.cgInst);
	nbpAddTriggerGen(self.id, other.tgInst);
}
with (oNBP_Trigger)
{
	nbpSetShape(self.id, NBPShape.CIRCLE);
}