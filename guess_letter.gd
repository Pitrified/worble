class_name GuessLetter
extends Button

var value: String = '_'
var letter_state: String = 'base'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func reset_guess_letter():
	value = '_'

func set_content(content: String):
	value = content
	text = content

func set_letter_state(state: String):
	letter_state = state
	if letter_state == 'correct':
		modulate = Color(0, 1, 0)
	elif letter_state == 'present':
		modulate = Color(0, 0, 1)
	elif letter_state == 'missing':
		modulate = Color(1, 0, 0)
	else:
		modulate = Color(1, 1, 1)
