class_name GuessLetter
extends Button

var value: String = '_'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset_guess_letter():
	value = '_'

func set_content(content: String):
	value = content
	text = content