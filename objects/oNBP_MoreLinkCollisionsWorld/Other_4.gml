// Init player
with (oNBP_PlayerTD)
{
	shape = NBPShape.RECT;
	nbpAddContactGen(self.id, other.cgInst);
}