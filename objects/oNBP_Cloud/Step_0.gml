// Cycle
var _spawnBound = 128, _despawnBound = 144;
if (x > room_width + _despawnBound) x = -_spawnBound;
if (x < -_despawnBound) x = room_width + _spawnBound;