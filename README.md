![nphysics-thumb-1](https://github.com/user-attachments/assets/88605752-31ef-4200-87a7-dfd005f705fc)


nbphysics is a 2D hybrid physics engine made for GameMaker in GameMaker Studio 2 LTS. It supports collision detection and resolution of non-rotated rectangles, rotated rectangles, and circles. I made it because I plan to use it in my future games so it should get better over time!

# Features
![nbp-1](https://github.com/user-attachments/assets/e62c2a29-e6c0-4fbf-9f71-55348a3db398)
- Physics worlds: objects that keep track of and update rigid bodies and triggers
- Rigid bodies: the physics objects that are affected by forces and collisions
- Triggers: Can detect the entering and exiting of rigid bodies
- 3 supported shapes: rectangles, rotated rectangles and circles
- Various built-in force generators such as springs, buoyancy and wind
- Various built-in collision generators such as instance collisions (with supported shapes), rods and cables
- A fully functional demo platformer
- Various other demos showcasing different parts of the engine
- 2 bitmask layers for collisions: one for where objects 'live', the other for what they can collide with
- No current torque handling, but there is rotation handling
- Sleep system for rigid bodies to improve performance
- Vector2 and 2x2 Matrix structs
- Support for custom force and contact generators
- Support for custom forces using nbpAddForce anywhere
- Support for multiple physics worlds
- Global functions for manipulating rigid bodies, physics worlds and triggers
- Adjustable simulation speed

# How to use
You can look at the demos to give you an idea of how to work with it. Generally:
1. instantiate a physics world
2. create rigid bodies (they'll automatically get recognized by the physics world)
3. create force and contact generators
4. link the generators to the desired bodies (using nbpAddForceGen() or nbpAddContactGen())
5. (optional) create a trigger and link it to the rigid body
And that's it! The generators should apply the forces/check collisions every frame. When you're done with a rigid body, you can safely destroy it!
