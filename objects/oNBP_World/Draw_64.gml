// Title
draw_set_halign(fa_right);
draw_set_valign(fa_top);
xCursor = room_width - 8;
yCursor = 24;
ySpacing = 16;
draw_text(xCursor, yCursor, name);
yCursor += ySpacing * 2;
draw_text(xCursor, yCursor, "simulation speed (x0.25) : shift");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "next demo : ->");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "prev demo : <-");
