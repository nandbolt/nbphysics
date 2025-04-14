/// @func	PhysicsWorld(maxContacts, iterations);
///	@param	{real}	maxContacts	The max amount of contacts that can exist per step.
///	@param	{real}	iterations	The amount of iterations the contact resolver can
///								do per step.
///	@desc	Houses and runs a physics simulation.
function PhysicsWorld(_maxContacts=32, _iterations=64) constructor
{
	// Bodies
	bodies = [];
	
	// Forces
	forceRegisty = new ForceRegistry();
	
	#region Events
	
	///	@func	cleanup();
	///	@desc	Cleans up data within a physics world.
	static cleanup = function(){}
	
	///	@func	drawGuiDebug();
	///	@desc	Displays all debug info the the overall physics world.
	static drawGuiDebug = function()
	{
		// Setup
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		var _x = 8, _y = 8, _ySpacing = 16;
		
		// Text
		draw_text(_x, _y, "Physics World");
		_y += _ySpacing;
		draw_text(_x, _y, string("bodies: {0}", array_length(bodies)));
		_y += _ySpacing;
		draw_text(_x, _y, string("force regs: {0}", forceRegisty.getRegistrationCount()));
		_y += _ySpacing;
	}
	
	#endregion
	
	#region Simulation
	
	///	@func	startFrame();
	///	@desc	Inits the world before a simulation frame.
	static startFrame = function()
	{
		// Go through bodies
		for (var _i = 0; _i < array_length(bodies); _i++)
		{
			// Clear forces
			var _rb = bodies[_i];
			if (is_struct(_rb)) _rb.clearForces();
		}
	}
	
	///	@func	integrate(dt);
	///	@para	{real}	dt	The change in time in the simulation.
	///	@desc	Integrates all bodies forward in time in the simulation.
	static integrate = function(_dt)
	{
		// Go through bodies
		for (var _i = 0; _i < array_length(bodies); _i++)
		{
			// Integrate body
			var _rb = bodies[_i];
			if (is_struct(_rb)) _rb.integrate(_dt);
		}
	}
	
	///	@func	runPhysics(dt);
	///	@para	{real}	dt	The change in time in the simulation.
	///	@desc	Processes all physics within the simulation.
	static runPhysics = function(_dt)
	{
		// Apply force generators
		forceRegisty.updateForces(_dt);
		
		// Integrate bodies
		integrate(_dt);
		
		// Process contacts
	}
	
	#endregion
	
	#region Helpers
	
	///	@func	addBody(body);
	///	@param	{Struct.RigidBody}	rb	The body to add.
	///	@desc	Adds the body to the physics world simulation.
	static addBody = function(_body)
	{
		array_push(bodies, _body);
		_body.physicsWorld = self;
	}
	
	///	@func	removeBody(rb);
	///	@param	{Struct.RigidBody}	rb	The body to remove.
	///	@desc	Removes the given body from the rigid body if it exists within the world.
	static removeBody = function(_rb)
	{
		// Unregister body from force registry
		forceRegisty.unregisterBody(_rb);
		
		// Go through bodies
		for (var _i = 0; _i < array_length(bodies); _i++)
		{
			// If body found
			if (bodies[_i] == _rb)
			{
				// Remove body from simulation and exit loop
				array_delete(bodies, _i, 1);
				_rb.physicsWorld = undefined;
				break;
			}
		}
	}
	
	#endregion
}