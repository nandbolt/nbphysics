// Inherit the parent event
event_inherited();

// Name
name = "Links";

// Boxes
box1 = instance_create_layer(room_width * 1.5 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);
box2 = instance_create_layer(room_width * 2.5 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);
box3 = instance_create_layer(room_width * 3 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);
box4 = instance_create_layer(room_width * 4 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);
box5 = instance_create_layer(room_width * 5 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);
box6 = instance_create_layer(room_width * 6 / 8, room_height * 0.125, "Instances", oNBP_BoxSV);

// Links
cgCable1 = new CableContactGen(box1, box2, room_width * 1 / 8);
nbpAddContactGen(box1, cgCable1);
nbpAddContactGen(box2, cgCable1);
cgCable2 = new CableContactGen(box2, box3, room_width * 1 / 8);
nbpAddContactGen(box2, cgCable2);
nbpAddContactGen(box3, cgCable2);
cgRod1 = new RodContactGen(box4, box5, room_width * 1 / 8);
cgRod1.restitution = 1;
nbpAddContactGen(box4, cgRod1);
nbpAddContactGen(box5, cgRod1);
cgRod2 = new RodContactGen(box5, box6, room_width * 1 / 8);
cgRod2.restitution = 1;
nbpAddContactGen(box5, cgRod2);
nbpAddContactGen(box6, cgRod2);

// Init boxes
with (oNBP_BoxSV)
{
	nbpSetShape(self.id, NBPShape.CIRCLE);
	image_xscale = 9;
	image_yscale = 9;
	
	// Wake
	nbpSetAwake(self.id, true);
}

// Environment boxes
with (box3)
{
	color = c_lime;
	grav.set();
	inverseMass = 0;
}
with (box6)
{
	color = c_lime;
	grav.set();
	inverseMass = 0;
}