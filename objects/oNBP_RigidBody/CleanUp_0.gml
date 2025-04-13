// Rigid body
if (is_struct(rb))
{
	rb.cleanup();
	delete rb;
}