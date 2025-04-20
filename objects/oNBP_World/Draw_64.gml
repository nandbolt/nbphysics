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

// Player debug
if (instance_exists(oNBP_PlayerTD))
{
	yCursor += ySpacing * 2;
	draw_text(xCursor, yCursor, "player");
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("fgs: {0}", string(oNBP_PlayerTD.forceGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("cgs: {0}", string(oNBP_PlayerTD.contactGens)));
}
else if (instance_exists(oNBP_PlayerSV))
{
	yCursor += ySpacing * 2;
	draw_text(xCursor, yCursor, "player");
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("fgs: {0}", string(oNBP_PlayerSV.forceGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("cgs: {0}", string(oNBP_PlayerSV.contactGens)));
	yCursor += ySpacing;
	draw_text(xCursor, yCursor, string("grav: {0}", string(oNBP_PlayerSV.grav)));
}