#region Rigid Body

#region Setters/Getters
	
///	@func	nbpGetMass(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@return	{real}	The body's mass.	
///	@desc	Returns the mass of the rigid body.
function nbpGetMass(_rb)
{
	if (_rb.inverseMass == 0) return infinity;
	return 1 / _rb.inverseMass;
}
	
///	@func	nbpSetMass(rb, mass);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	mass	The new mass.	
///	@desc	Sets the mass of the rigid body.
function nbpSetMass(_rb, _mass)
{
	if (_mass == 0) throw("Set mass error. Mass can't be zero!");
	_rb.inverseMass = 1 / _mass;
}

///	@func	nbpGetWidth(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@return	{real}	The width of the body.
///	@desc	Returns the width of the body.
function nbpGetWidth(_rb)
{
	if (_rb.shape == NBPShape.RECT_ROTATED)
	{
		var _angle = _rb.image_angle;
		_rb.image_angle = 0;
		var _w = _rb.bbox_right - _rb.bbox_left;
		_rb.image_angle = _angle;
		return _w;
	}
	return _rb.bbox_right - _rb.bbox_left;
}
	
///	@func	nbpGetHeight(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@return	{real}	The width of the body.
///	@desc	Returns the width of the body.
function nbpGetHeight(_rb)
{
	if (_rb.shape == NBPShape.RECT_ROTATED)
	{
		var _angle = _rb.image_angle;
		_rb.image_angle = 0;
		var _h = _rb.bbox_bottom - _rb.bbox_top;
		_rb.image_angle = _angle;
		return _h;
	}
	return _rb.bbox_bottom - _rb.bbox_top;
}

///	@func	nbpGetRadius(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@return	{real}	The radius of the body.
///	@desc	Returns the radius of the body.
function nbpGetRadius(_rb)
{
	var _w = _rb.bbox_right - _rb.bbox_left, _h = _rb.bbox_bottom - _rb.bbox_top;
	if (_w > _h) return _h * 0.5;
	return _w * 0.5;
}

///	@func	nbpSetAngle(rb, angle);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	angle	The new angle.
///	@desc	Sets the angle of the rigid body.
function nbpSetAngle(_rb, _angle)
{
	_rb.image_angle = _angle;
	if (_rb.shape == NBPShape.RECT_ROTATED) _rb.orientation.setRotation(-_rb.image_angle);
}

///	@func	nbpSetShape(rb, shape);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	shape	The new shape.
///	@desc	Sets the shape of the rigid body.
function nbpSetShape(_rb, _shape)
{
	_rb.shape = _shape;
	switch (_shape)
	{
		case NBPShape.RECT:
			_rb.orientation.setRotation(0);
			
			// Draw
			_rb.funcDrawShape = nbpDrawRect;
			_rb.color = #ffff55;
			break;
		case NBPShape.CIRCLE:
			_rb.orientation.setRotation(0);
			
			// Draw
			_rb.funcDrawShape = nbpDrawCircle;
			_rb.color = #55ff55;
			break;
		case NBPShape.RECT_ROTATED:
			_rb.orientation.setRotation(-_rb.image_angle);
			
			// Draw
			_rb.funcDrawShape = nbpDrawRotatedRect;
			_rb.color = #ff5555;
			break;
	}
}
	
#endregion
	
#region Properties
	
///	@func	nbpHasFiniteMass(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Returns true if the body has finite mass, false if infinite (or immoveable).
function nbpHasFiniteMass(_rb){ return _rb.inverseMass > 0; }
	
#endregion
	
#region Simulation
	
///	@func	nbpClearForces(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Clears the forces acting on the body.
function nbpClearForces(_rb){ _rb.force.set(); }
	
///	@func	nbpAddForce(rb, fx, fy);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	fx	The force x-coordinate to add.	
///	@param	{real}	fy	The force y-coordinate to add.	
///	@desc	Adds the force to the net force.
function nbpAddForce(_rb, _fx, _fy){ _rb.force.add(_fx, _fy); }
	
///	@func	nbpAddForceVector(rb, f);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{Struct.Vector2}	f	The force vector to add.	
///	@desc	Adds the force to the net force.
function nbpAddForceVector(_rb, _f){ _rb.force.addVector(_f); }

///	@func	nbpAddForceGen(rb, fg);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{Struct.ForceGen}	fg	The force gen.
///	@desc	Adds a force generator to the rigid body.
function nbpAddForceGen(_rb, _fg)
{
	array_push(_rb.forceGens, _fg);
}

///	@func	nbpRemoveForceGen(rb, fg);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{Struct.ForceGen}	fg	The force gen.
///	@desc	Removes a force generator from the rigid body.
function nbpRemoveForceGen(_rb, _fg)
{
	// Go through force gens
	for (var _i = 0; _i < array_length(_rb.forceGens); _i++)
	{
		// If found force gen
		if (_rb.forceGens[_i] == _fg)
		{
			// Remove force gen and exit loop
			array_delete(_rb.forceGens, _i, 1);
			break;
		}
	}
}

///	@func	nbpClearForceGens(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Clears all force generators from the rigid body.
function nbpClearForceGens(_rb){ _rb.forceGens = []; }

///	@func	nbpApplyForceGens(rb, dt);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	dt	The change in time in the simulation.
///	@desc	Applies all of the registered force gens to the rigid body.
function nbpApplyForceGens(_rb, _dt)
{
	// Go through force gens
	for (var _i = 0; _i < array_length(_rb.forceGens); _i++)
	{
		var _fg = _rb.forceGens[_i];
		_fg.updateForce(_rb, _dt);
	}
}

///	@func	nbpAddContactGen(rb, cg);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{Struct.ContactGen}	cg	The contact gen.
///	@desc	Adds a contact generator to the rigid body.
function nbpAddContactGen(_rb, _cg)
{
	array_push(_rb.contactGens, _cg);
}

///	@func	nbpRemoveContactGen(rb, cg);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{Struct.ContactGen}	cg	The contact gen.
///	@desc	Removes a contact generator from the rigid body.
function nbpRemoveContactGen(_rb, _cg)
{
	// Go through contact gens
	for (var _i = 0; _i < array_length(_rb.contactGens); _i++)
	{
		// If found contact gen
		if (_rb.contactGens[_i] == _cg)
		{
			// Remove contact gen and exit loop
			array_delete(_rb.contactGens, _i, 1);
			break;
		}
	}
}

///	@func	nbpClearContactGens(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Clears all contact generators from the rigid body.
function nbpClearContactGens(_rb){ _rb.contactGens = []; }

///	@func	nbpIntegrate(rb, dt);
///	@param	{Id.Instance}	rb	The rigid body.
///	@param	{real}	dt	The change in time of the simulation.
///	@desc	Updates the body forward in time in the simulation. This means turning a
///			net force -> acceleration -> velocity -> position.
function nbpIntegrate(_rb, _dt)
{
	// Make sure time isn't zero
	if (_dt <= 0) throw("Integration error. Delta time can't be <= 0!");
	
	// Rigid body scope
	with (_rb)
	{
		// Store previous force
		prevForce.setVector(force);
		
		// Calculate acceleration
		acceleration.setScaledVector(force, inverseMass);
		
		// Add gravity
		acceleration.addVector(grav);
		
		// Calculate velocity
		velocity.addScaledVector(acceleration, _dt);
		
		// Apply velocity damping
		velocity.scale(power(damping, _dt));
		
		// Calculate position
		x += velocity.x;
		y += velocity.y;
	}
}

#endregion

#region Debug

///	@func	nbpDrawRect(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Draws the rigid body as a rectangle (using the bounding box).
function nbpDrawRect(_rb)
{
	with (_rb)
	{
		// Outlines
		if (outlines)
		{
			image_blend = c_dkgray;
			draw_set_color(c_dkgray);
			draw_self();
			draw_circle(x, y, nbpGetRadius(self.id), true);
		}
		
		// Rectangle
		draw_set_color(color);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		
		// Infinite mass dot
		if (inverseMass == 0)
		{
			draw_set_color(c_orange);
			draw_circle(x, y, 4, true);
		}
		
		// Reset color
		draw_set_color(c_white);
	}
}

///	@func	nbpDrawRotatedRect(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Draws the rigid body as a rotated rectangle.
function nbpDrawRotatedRect(_rb)
{
	with (_rb)
	{
		// Outlines
		if (outlines)
		{
			draw_set_color(c_dkgray);
			draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
			draw_circle(x, y, nbpGetRadius(self.id), true);
		}
		
		// Rotated rectangle
		image_blend = color;
		draw_self();
		
		// Infinite mass dot
		if (inverseMass == 0)
		{
			draw_set_color(c_orange);
			draw_circle(x, y, 4, true);
		}
		
		// Reset color
		draw_set_color(c_white);
	}
}

///	@func	nbpDrawCircle(rb);
///	@param	{Id.Instance}	rb	The rigid body.
///	@desc	Draws the rigid body as a rectangle (using the bounding box).
function nbpDrawCircle(_rb)
{
	with (_rb)
	{
		// Outlines
		if (outlines)
		{
			image_blend = c_dkgray;
			draw_set_color(c_dkgray);
			draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
			draw_self();
		}
		
		// Circle
		draw_set_color(color);
		draw_circle(x, y, nbpGetRadius(self.id), true);
		
		// Infinite mass dot
		if (inverseMass == 0)
		{
			draw_set_color(c_orange);
			draw_circle(x, y, 4, true);
		}
		
		// Reset color
		draw_set_color(c_white);
	}
}

#endregion

#endregion

#region PhysicsWorld

#region Properties

///	@func	nbpGetRigidBodyCount(pw);
///	@param	{Id.Instance}	pw	The physics world.
///	@desc	Returns the amount of rigid bodies within the physics simulation.
function nbpGetRigidBodyCount(_pw){ return instance_number(_pw.rbObject); }

#endregion

#region Simulation

///	@func	nbpInitNextPhysicsFrame(pw);
///	@param	{Id.Instance}	pw	The physics world.
///	@desc	Inits the world before a simulation frame.
function nbpInitNextPhysicsFrame(_pw)
{
	// Go through bodies
	with (_pw.rbObject)
	{
		// Clear forces
		nbpClearForces(self.id);
	}
}
	
///	@func	nbpRunPhysics(pw, dt);
///	@param	{Id.Instance}	pw	The physics world.
///	@para	{real}	dt	The change in time in the simulation.
///	@desc	Processes all physics within the simulation.
function nbpRunPhysics(_pw, _dt)
{
	// Apply force generators
	with (_pw.rbObject)
	{
		nbpApplyForceGens(self.id, _dt);
	}
		
	// Integrate bodies
	with (_pw.rbObject)
	{
		nbpIntegrate(self.id, _dt);
	}
		
	// Generate contacts
	var _usedContacts = nbpGenerateContacts(_pw);
	
	// Process contacts
	if (_usedContacts > 0)
	{
		with (_pw)
		{
			if (calculateIterations) contactResolver.setIterations(_usedContacts * 2);
			contactResolver.resolveContacts(contacts, _usedContacts, _dt);
		}
	}
}

///	@func	nbpGenerateContacts(pw);
///	@param	{Id.Instance}	pw	The physics world.
///	@return	{real}	The number of contacts.
///	@desc	Calls all contact generators and reports their contacts, returning the number of contacts.
function nbpGenerateContacts(_pw)
{
	// Init contact cursor
	var _limit = _pw.maxContacts;
	_pw.nextContactIdx = 0;
	
	// Loop through bodies
	with (_pw.rbObject)
	{
		// Loop through registered contact generators
		for (var _i = 0; _i < array_length(contactGens); _i++)
		{
			// Check for contacts
			var _used = contactGens[_i].addContact(self.id, _pw, _limit);
			_limit -= _used;
			_pw.nextContactIdx += _used;
			
			// Return if limit reached (meaning we'll have to ignore some contacts this step)
			if (_limit <= 0) return _pw.maxContacts;
		}
	}
	
	// Return contacts used
	return _pw.maxContacts - _limit;
}
	
#endregion

#endregion