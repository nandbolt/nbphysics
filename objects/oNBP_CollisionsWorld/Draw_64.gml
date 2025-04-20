// Inherit the parent event
event_inherited();

// Move
yCursor += ySpacing;
draw_text(xCursor, yCursor, "move : awsd");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "rotate player : /|\\ \\|/");
yCursor += ySpacing;
draw_text(xCursor, yCursor, "toggle rotate : tab");