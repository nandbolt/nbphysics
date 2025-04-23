/// @desc Set Move input
moveInput.x = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * moveStrength;
moveInput.y = 0;

// Grounded
if (array_length(normals) > 0)
{
	groundBuffer = groundBufferAmount;
	groundNormal.setVector(normals[0]);
}
else groundBuffer = clamp(groundBuffer - 1, 0, groundBufferAmount);

// Water
var _inWater = false;
for (var _i = 0; _i < array_length(triggers); _i++)
{
	if (triggers[_i].object_index == oNBP_Water)
	{
		_inWater = true;
		moveInput.y = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * moveStrength;
		break;
	}
}

// Jump buffer
if (keyboard_check_pressed(vk_space)) jumpBuffer = jumpBufferAmount;
else jumpBuffer = clamp(jumpBuffer - 1, 0, jumpBufferAmount);

// Coyote buffer
if (groundBuffer > 0) coyoteBuffer = coyoteBufferAmount;
else coyoteBuffer = clamp(coyoteBuffer - 1, 0, coyoteBufferAmount);

// Ground friction
if (groundBuffer > 0 && moveInput.x == 0 && !keyboard_check(vk_space)) damping = lerp(damping, 0, 0.1);
else damping = 0.25;

// Jump
if (jumpBuffer > 0 && (coyoteBuffer > 0 || _inWater))
{
	moveInput.y = -50000;
	if (_inWater) moveInput.y *= 0.5;
	jumpBuffer = 0;
	coyoteBuffer = 0;
}

// Inherit the parent event
event_inherited();