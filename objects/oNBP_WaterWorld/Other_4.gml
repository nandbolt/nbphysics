// Add buoyancy to bodies
with (oNBP_BoxSV)
{
	nbpAddForceGen(self.id, other.fgBuoyancy);
}
with (oNBP_PlayerSV)
{
	nbpAddForceGen(self.id, other.fgBuoyancy);
}