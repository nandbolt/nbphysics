// Inherit the parent event
event_inherited();

// Name
name = "More Links";

// Boxes
box1 = instance_create_layer(room_width * 1 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box2 = instance_create_layer(room_width * 2 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box3 = instance_create_layer(room_width * 3 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box4 = instance_create_layer(room_width * 4 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box5 = instance_create_layer(room_width * 5 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box6 = instance_create_layer(room_width * 6 / 8, room_height * 0.4, "Instances", oNBP_BoxSV);
box7 = instance_create_layer(room_width * 1 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);
box8 = instance_create_layer(room_width * 2 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);
box9 = instance_create_layer(room_width * 3 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);
box10 = instance_create_layer(room_width * 4 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);
box11 = instance_create_layer(room_width * 5 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);
box12 = instance_create_layer(room_width * 6 / 8, room_height * 0.6, "Instances", oNBP_BoxSV);

// Instance collisions
cgInst = new InstContactGen();

// Links
cgCable1 = new CableContactGen(box1, box2, room_width * 1 / 8);
nbpAddContactGen(box1, cgCable1);
nbpAddContactGen(box2, cgCable1);
cgCable2 = new CableContactGen(box2, box3, room_width * 1 / 8);
nbpAddContactGen(box2, cgCable2);
nbpAddContactGen(box3, cgCable2);
cgRod1 = new RodContactGen(box4, box5, room_width * 1 / 8);
nbpAddContactGen(box4, cgRod1);
nbpAddContactGen(box5, cgRod1);
cgRod2 = new RodContactGen(box5, box6, room_width * 1 / 8);
nbpAddContactGen(box5, cgRod2);
nbpAddContactGen(box6, cgRod2);
cgCable3 = new CableContactGen(box7, box8, room_width * 1 / 8);
nbpAddContactGen(box7, cgCable3);
nbpAddContactGen(box8, cgCable3);
cgCable4 = new CableContactGen(box8, box9, room_width * 1 / 8);
nbpAddContactGen(box8, cgCable4);
nbpAddContactGen(box9, cgCable4);
cgRod3 = new RodContactGen(box10, box11, room_width * 1 / 8);
nbpAddContactGen(box10, cgRod3);
nbpAddContactGen(box11, cgRod3);
cgRod4 = new RodContactGen(box11, box12, room_width * 1 / 8);
nbpAddContactGen(box11, cgRod4);
nbpAddContactGen(box12, cgRod4);

// Init boxes
with (oNBP_BoxSV)
{
	nbpSetShape(self.id, NBPShape.CIRCLE);
	grav.set();
	image_xscale = 9;
	image_yscale = 9;
}

// Environment boxes
with (box3)
{
	color = c_lime;
	inverseMass = 0;
}
with (box6)
{
	color = c_lime;
	inverseMass = 0;
}