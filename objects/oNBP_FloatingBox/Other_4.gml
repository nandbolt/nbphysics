/// @desc Link Cable

// Cable
var _dist = point_distance(x, y, oNBP_BoxTD.x, oNBP_BoxTD.y) + 300;
cgCable = new CableContactGen(self.id, oNBP_BoxTD, _dist);
nbpAddContactGen(self.id, cgCable);