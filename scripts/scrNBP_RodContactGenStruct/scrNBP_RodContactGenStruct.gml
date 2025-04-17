///	@func	RodContactGen(rb1, rb2, length);
///	@param	{Id.Instance}	rb1	The first rigid body.
///	@param	{Id.Instance}	rb2	The second rigid body.
///	@param	{real}	maxLength	The max cable length.
///	@desc	Handles contacts between bodies connected via a rod.
function RodContactGen(_rb1=noone, _rb2=noone, _length=128) : LinkContactGen(_rb1, _rb2) constructor
{
	// Properties
	length = _length;
	
	///	@func	addContact(rb, pw, limit);
	///	@param	{Id.Instance}	rb	The rigid body.
	///	@param	{Id.Instance}	pw	The physics world.
	///	@param	{real}	limit		The number of contacts that can be written to.
	///	@desc	Fills the contact structure with generated contacts.
	static addContact = function(_rb, _pw, _limit)
	{
		// Get length
		var _len = currentLength();
		
		// Return if not overextended
		if (_len == length) return 0;
		
		// Get contact index
		var _contactIdx = _pw.nextContactIdx;
			
		// Get and clear contact
		var _contact = _pw.contacts[_contactIdx];
		
		// Clear contact
		_contact.clear();
		
		// Set rigid bodies
		_contact.rb1 = rb1;
		_contact.rb2 = rb2;
			
		// Normal
		_contact.normal.set(rb2.x - rb1.x, rb2.y - rb1.y);
		_contact.normal.normalize();
		
		// Normal direction depends on compression or extension
		if (_len > length)
		{
			// Compress
			_contact.penetration = _len - length;
		}
		else
		{
			// Extend
			_contact.normal.invert();
			_contact.penetration = length - _len;
		}
		
		// Zero restitution (no bounce)
		_contact.restitution = 0;
		
		// Return used
		return 1;
	}
}