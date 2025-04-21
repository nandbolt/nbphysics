// Add buoyancy + collisions to bodies
with (oNBP_RigidBody)
{
	if (inverseMass > 0) nbpAddForceGen(self.id, other.fgBuoyancy);
	nbpAddContactGen(self.id, other.cgInst);
}