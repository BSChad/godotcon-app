class_name ContactController
extends Control


@export var error_theme: Theme

@onready var first_name_text = $ScrollContainer/VBoxContainer/FirstNameTextEdit
@onready var last_name_text = $ScrollContainer/VBoxContainer/LastNameTextEdit
@onready var email_text = $ScrollContainer/VBoxContainer/EmailTextEdit
@onready var home_phone_text = $ScrollContainer/VBoxContainer/HomePhoneTextEdit
@onready var cell_phone_text = $ScrollContainer/VBoxContainer/CellPhoneTextEdit

var vcard := VCard.new()
var regex = RegEx.new()


func _ready() -> void:
	regex.compile("^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]\\d{3}[\\s.-]\\d{4}$")


func _on_create_qr_button_pressed() -> void:
	vcard.properties[VCardProps.VC_EMAIL] = $ScrollContainer/VBoxContainer/EmailTextEdit.text
	var card_string = vcard.as_string()
	var file = FileAccess.open("user://contact.vcf", FileAccess.WRITE)
	file.store_string(card_string)
	print(file.get_path_absolute())


func _on_nfc_button_pressed() -> void:
	pass # Replace with function body.


func _on_name_text_edit_text_changed() -> void:
	vcard.setName(first_name_text.text, last_name_text.text)


func _on_email_text_edit_text_changed() -> void:
	vcard.setEmail(email_text.text)


func _on_phone_text_edit_text_changed(is_cell: bool) -> void:
	var number_text := ""
	if is_cell:
		number_text = cell_phone_text.text
	else:
		number_text = home_phone_text.text
	
	if regex.search(number_text):
		# Is this too US centric?
		if number_text.length() > 9:
			vcard.setPhoneNumber(number_text, is_cell)
		if is_cell:
			cell_phone_text.theme = null
		else:
			home_phone_text.theme = null
	else:
		if is_cell:
			cell_phone_text.theme = error_theme
		else:
			home_phone_text.theme = error_theme
	
