// Name
name = "World";

// Create physics world object
instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);

// Show debugger
show_debug_overlay(true);

// Menu
yCursor = 0;
xCursor = 0;
ySpacing = 16;

// Worlds
worldRooms = [
	rNBP_Platformer,
	rNBP_Rain,
	rNBP_Spring,
	rNBP_Water,
	rNBP_CircleCollisions,
	rNBP_RectCollisions,
	rNBP_CircleRectCollisions,
	rNBP_LinkCollisions,
	rNBP_MoreLinkCollisions,
	rNBP_StackedBoxes,
	rNBP_RotatedRectCollisions,
	rNBP_Collisions,
	rNBP_LayerCollisions,
	rNBP_HighSpeedCollisions,
];

///	@func	GetWorldRoomIdx();
GetWorldRoomIdx = function()
{
	for (var _i = 0; _i < array_length(worldRooms); _i++)
	{
		if (worldRooms[_i] == room) return _i;
	}
	return -1;
}

///	@func	GoToNextRoom();
GoToNextRoom = function()
{
	var _idx = GetWorldRoomIdx() + 1;
	if (_idx >= array_length(worldRooms)) _idx = 0;
	GoToRoom(_idx);
}

///	@func	GoToPreviousRoom();
GoToPreviousRoom = function()
{
	var _idx = GetWorldRoomIdx() - 1;
	if (_idx <= -1) _idx = array_length(worldRooms) - 1;
	GoToRoom(_idx);
}

///	@func	GoToRoom(idx);
///	@param	{real}	idx
GoToRoom = function(_idx)
{
	var _room = worldRooms[_idx];
	if (room_exists(_room)) room_goto(_room);
}