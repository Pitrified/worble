class_name GuessLetter
extends Button

const guess_letter_scene: PackedScene = preload("res://guess_letter.tscn")

signal guess_letter_pressed(letter_id: int)

var value: String = '_'
var letter_state: String = 'base'
var letter_id: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# func reset_guess_letter():
# 	value = '_'

static func new_guess_letter(
	value_: String,
	letter_state_: String,
	letter_id_: int,
	_on_guess_letter_pressed: Callable
) -> GuessLetter:
	# var gl = GuessLetter.new()
	var gl: GuessLetter = guess_letter_scene.instantiate()
	gl.set_content(value_)
	gl.set_letter_state(letter_state_)
	gl.letter_id = letter_id_
	gl.connect('guess_letter_pressed', _on_guess_letter_pressed)
	return gl

func set_content(content: String):
	value = content
	text = value

func set_letter_state(state: String):
	letter_state = state
	if letter_state == 'correct':
		modulate = KbButton.color_correct
	elif letter_state == 'present':
		modulate = KbButton.color_present
	elif letter_state == 'missing':
		modulate = KbButton.color_missing
	else:
		modulate = KbButton.color_base

func _on_pressed():
	print('guess_letter: Button pressed: ' + value + ' id ' + str(letter_id))
	guess_letter_pressed.emit(letter_id)
