/// @func	ForceGen();
///	@desc	Adds forces to 'registered' bodies. Only inherited force generators will be instanced.
function ForceGen() constructor
{
	///	@func	updateForce(rigidBody, dt);
	///	@param	{Struct.RigidBody}	rigidBody	The rigid body the force is being applied to.
	///	@param	{real}	dt	The change in time of the simulation.
	///	@desc	Applies the force to the body. Should be overwritten.
	static updateForce = function(_rb, _dt){}
}

/// @func	ForceReg(rigidBody, fg);
///	@param	{Struct.RigidBody}	rigidBody	The rigid body that is registering.
///	@param	{Struct.ForceGen}	dt	The change in time of the simulation.
///	@desc	Adds forces to 'registered' bodies. Only inherited force generators will be instanced.
function ForceReg(_rb, _fg) constructor
{
	rb = _rb;
	fg = _fg;
}

///	@func	ForceRegistry();
///	@desc	Holds the force registrations and applies the registrations to the given bodies.
function ForceRegistry() constructor
{
	registrations = [];
	
	#region Events
	
	///	@func	cleanup();
	static cleanup = function()
	{
		// Go through registrations
		for (var _i = 0; _i < array_length(registrations); _i++)
		{
			// Delete if valid registration
			var _reg = registrations[_i];
			if (is_struct(_reg)) delete _reg;
		}
	}
	
	#endregion
	
	#region Properties
	
	///	@func	getRegistrationCount();
	///	@return	{real}	The amount of registrations.
	///	@desc	Returns the amount of force registrations there are.
	static getRegistrationCount = function(){ return array_length(registrations); }
	
	#endregion
	
	#region Simulation
	
	///	@func	updateForces(dt);
	///	@param	{real}	dt	The change in time of the physics world.
	///	@desc	Applies all of the registered forces to their corresponding body.
	static updateForces = function(_dt)
	{
		// Go through the registry
		var _count = array_length(registrations);
		for (var _i = _count-1; _i >= 0; _i--)
		{
			// Apply registration
			var _rb = registrations[_i].rb, _fg = registrations[_i].fg;
			if (is_struct(_rb) && is_struct(_fg)) _fg.updateForce(_rb, _dt);
			else
			{
				// Manually remove registration
				delete registrations[_i];
				array_delete(registrations, _i, 1);
			}
		}
	}
	
	#endregion
	
	#region Helpers
	
	///	@func	addReg(rb, fg);
	///	@param	{Struct.RigidBody}	rb	The rigid body registering.
	///	@param	{Struct.ForceGen}	fg	The force generator registering.
	///	@desc	Registers the given rigid body and force generator.
	static addReg = function(_rb, _fg){ array_push(registrations, new ForceReg(_rb, _fg)); }
	
	///	@func	removeReg(rb, fg);
	///	@param	{Struct.RigidBody}	rb	The rigid body unregistering.
	///	@param	{Struct.ForceGen}	fg	The force generator unregistering.
	///	@desc	Registers the given rigid body and force generator.
	static removeReg = function(_rb, _fg)
	{
		// Go through registrations
		for (var _i = 0; _i < array_length(registrations); _i++)
		{
			var _reg = registrations[_i];
			if (_reg.rb == _rb && _reg.fg == _fg)
			{
				// Delete registration and exit loop
				delete _reg;
				array_delete(registrations, _i, 1);
				break;
			}
		}
	}
	
	///	@func	clear();
	///	@desc	Clears all registrations (without disturbing bodies).
	static clear = function()
	{
		// Go through registrations
		for (var _i = 0; _i < array_length(registrations); _i++)
		{
			// Delete registrations
			var _reg = registrations[_i];
			if (is_struct(_reg)) delete _reg;
		}
		
		// Reset array
		registrations = [];
	}
	
	///	@func	unregisterBody(rb);
	///	@param	{Struct.RigidBody}	rb	The rigid body to unregister.
	///	@desc	Unregisters the rigid body from all force generators.
	static unregisterBody = function(_rb)
	{
		// Go through registrations
		var _count = getRegistrationCount();
		for (var _i = _count - 1; _i >= 0; _i--)
		{
			// If rigid body apart of this registration
			var _reg = registrations[_i];
			if (is_struct(_reg) && _reg.rb == _rb)
			{
				// Delete registration
				delete _reg;
				array_delete(registrations, _i, 1);
			}
		}
	}
	
	#endregion
}