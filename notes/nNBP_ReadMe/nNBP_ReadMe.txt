HOW TO USE NBPHYSICS
by nandbolt

~~~~~~~~~~~~~~
Step 0: Intro!

Hello! Welcome to nbphysics, a 2D physics engine made by me. I am heavily utilizing
Ian Millington's book 'Game Physics Engine Development', so go check it out if you want
to learn from the source!

What type of engine is nbphysics?
- MASS-AGGREGATE: bodies are made up of smaller bodies, ignoring rotations
	- hopefully I'll be able to upgrade it to a rigid body engine soon, one that treats bodies
	  as a whole and accounts for rotations
- ITERATIVE: contacts are processed iteratively, or one-by-one, and is a fast and easy approach
  at the cost of accuracy.
	- another method, known as the 'Jacobian-based' method, is more complex but more accurate
	- another method, known as the 'reduced coordinate approach', is used in engineering
	  applications mostly but is also slow
- IMPULSE-BASED: contacts are resolved by applying 'impulse' forces to objects, providing
  easy and flexible implementation.
	- another method is force-based in which everything is resolved through forces, which is
	  generally more mathematically intensive to implement

The key objects in nbphysics are:
- PhysicsWorld
	- houses and run the physics simulation.
- RigidBody
	- these are the bodies that move about in the simulation and can be influenced
	  by force and contact generators.

The key structs are:
- ForceGen
	- an interface for any type of force generator. These apply forces to any rigid
	  bodies that are 'registered' with the force.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Step 1: Define the 'physics world'.

There is no physics if there is no world! Create a physics world instance that will
house and run a simulation. You can setup the instance by changing the following:
- rbObject (object_index): changes what type of rigid body the physics world simulates.
  This allows you to create multiple physics worlds that use a different rbObject,
  allowing the simulations to be independent from one another! You can define a new
  type of rigid body object by creating a new rigid body that inherits from
  oNBP_RigidBody.

`
/// @desc	Create (in some sort of world/level object)
instance_create_layer(0, 0, "Instances", oNBP_PhysicsWorld);
`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Step 2: Define the 'rigid body'.

An empty world isn't a fun one! Create a rigid body instance. Don't worry, it'll
automatically be accounted for by a corresponding physics world so long as its
rbObject matches the rigid body's object_index. There are some built-in parameters
for rigid bodies. Feel free to change:
- grav (Vector2): applies gravity. By default, it's a zero vector.
- damping (real): applies drag. The closer to 1, the less drag. By default its 0.995.

`
/// @desc	Create (in some sort of actor/entity object)
rbBall = instance_create_layer(0, 0, "Instances", oNBP_RigidBody);
with (rbBall)
{
	grav.y = 10;
}
`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Step 2: Define the 'force gens'.

A body at rest will stay at rest! Create force generators and add them to the
corresponding rigid bodies. Force generators can be reused between rigid bodies.

`
/// @desc	Create (in some sort of actor/entity object)
fgWind = new WindForceGen();
nbpAddForceGen(rbBall, fgWind);
`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Step 3: Remove the 'rigid body'.

Hate to see you go! To remove a rigid body from a simulation, you can simply destroy
it. Things should clean themselves up nicely.

`
/// @desc	Step (in some sort of actor/entity object)
instance_destroy();
`