// Title
draw_set_halign(fa_right);
draw_set_valign(fa_top);
xCursor = display_get_gui_width() - 8;
yCursor = 24;
ySpacing = 16;
draw_text(xCursor, yCursor, name);
yCursor += ySpacing * 2;
draw_text(xCursor, yCursor, "simulation speed (x0.25) : control");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "simulation speed (x2) : shift");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "next demo : ->");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "prev demo : <-");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "fullscreen : f11");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "screenshot : f10");

// Player
if (instance_exists(oNBP_Player))
{
	yCursor += ySpacing * 2;
	draw_text(xCursor, yCursor, "player");
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("shape: {0}", string(oNBP_Player.shape)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("fgs: {0}", string(oNBP_Player.forceGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("cgs: {0}", string(oNBP_Player.contactGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("tgs: {0}", string(oNBP_Player.triggerGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("triggers: {0}", string(oNBP_Player.triggers)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("contacts: {0}", string(oNBP_Player.contacts)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("grav: {0}", string(oNBP_Player.grav)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("damping: {0}", string(oNBP_Player.damping)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("bounciness: {0}", string(oNBP_Player.bounciness)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("bitmask: {0}", oNBP_Player.bitmaskString));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("collision bitmask: {0}", oNBP_Player.collisionBitmaskString));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "change shape : left click");
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "rotate : scroll wheel");
}

// Player debug
if (instance_exists(oNBP_PlayerTD))
{
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "move : awsd");
}
else if (instance_exists(oNBP_PlayerSV))
{
	// Move
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "run : ad");
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "jump : space");
}

// Mouse push
if (instance_exists(oNBP_PlayerTDSpeedy))
{
	// Move
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, "highspeed push : right click");
}