// Inherit the parent event
event_inherited();

// Name
name = "Water";

// Link boxes to buoyancy force
fgBuoyancy = new BuoyancyForceGen(room_height * 0.75);