// Init player
with (oNBP_PlayerTD)
{
	nbpSetShape(self.id, NBPShape.RECT);
	nbpAddContactGen(self.id, other.cgInst);
}