// Contacts
delete contactResolver;
for (var _i = 0; _i < array_length(contacts); _i++)
{
	var _contact = contacts[_i];
	_contact.cleanup();
	delete _contact;
}
contacts = -1;