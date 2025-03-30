class_name VCard
extends Resource


@export var properties := {}


func setName (firstname: String, lastname: String, additional = "", prefix = "", suffix = ""):
	var fullname = (lastname + ";"
	+ firstname + ";"
	+ additional + ";"
	+ prefix + ";"
	+ suffix)
	properties[VCardProps.VC_NAME] = fullname
	properties[VCardProps.VC_FORMATTED_NAME] = firstname + " " + lastname


func setEmail(email):
	properties[VCardProps.VC_EMAIL] = email


func setAddress(street: String, locality: String, region: String, 
	postal_code: String, country: String, post_office_box = "", ext_address = ""):
	var address = (post_office_box + ";"
		+ ext_address  + ";"
		+ street + ";"
		+ locality + ";"
		+ region + ";"
		+ postal_code + ";"
		+ country)
	properties[VCardProps.VC_ADDRESS] = address


func setPhoneNumber(number: String, is_cell := false):
	var formatted_number_prop := VCardProps.VC_TELEPHONE
	if is_cell:
		formatted_number_prop += ";"+VCardProps.VC_TEL_TYPE_CELL+";"
	else:
		formatted_number_prop += ";"+VCardProps.VC_TEL_TYPE_HOME+";"
	properties[formatted_number_prop] = number


func setBirthday(year: int, month: int, day: int):
	var birthday := str("%4d-%2d-%2d", year, month, day)
	properties[VCardProps.VC_BIRTHDAY] = birthday


func setOrganization(name: String, levels = []):
	var org = name
	for level in levels:
		org += level
	properties[VCardProps.VC_ORGANIZATION] = org


func as_string() -> String:
	var vcf := "BEGIN:VCARD\n"
	vcf += "VERSION:3.0\n"
	for prop in properties:
		vcf += prop + ":" + properties[prop] + "\n"
	vcf += "END:VCARD"
	return vcf
