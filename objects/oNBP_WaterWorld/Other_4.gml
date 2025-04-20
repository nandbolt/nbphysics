// Add buoyancy + collisions to bodies
with (oNBP_RigidBody)
{
	nbpAddForceGen(self.id, other.fgBuoyancy);
	nbpAddContactGen(self.id, other.cgInst);
}
with (oNBP_BoxSV)
{
	inverseMass = 1 / 32;
}