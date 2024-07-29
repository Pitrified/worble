class_name KbButton
extends Button

# if it breaks, use the commented local version
const my_scene: PackedScene = preload('res://kb_button.tscn')

# signal button_down
signal kb_button_down(content: String)

var btn_content: String = ''
var btn_state: String = 'base'

# a map to show the user a different character for some keys
const SHOW_CHARS = {
	'enter': '↵',
	'backspace': '⌫',
	'.': '.',
}

const color_correct = Color(0, 1, 0)
const color_present = Color(0, 0, 1)
const color_missing = Color(1, 0, 0)
const color_base = Color(1, 1, 1)

# kinda constructor
# https://www.reddit.com/r/godot/comments/13pm5o5/instantiating_a_scene_with_constructor_parameters/
static func new_kb_button(content: String, _on_kb_button_down: Callable) -> KbButton:
	# var my_scene: PackedScene = load('res://kb_button.tscn')
	var kb_btn: KbButton = my_scene.instantiate()
	# set the button content
	kb_btn.btn_content = content
	# set the button text shown to the user
	kb_btn.text = SHOW_CHARS.get(content, content)
	# connect the signal to the receiver method
	kb_btn.connect('kb_button_down', _on_kb_button_down)
	# set the starting state of the button
	kb_btn.set_btn_state('base')
	return kb_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_btn_state(new_state: String):
	# if the button was already correct, don't change it
	if btn_state == 'correct':
		# modulate = Color(0, 1, 0)
		return

	elif btn_state == 'present':
		if new_state == 'correct':
			# if it was present and now it's correct, change the color
			modulate = color_correct
			btn_state = new_state

	elif btn_state == 'missing':
		if new_state == 'correct':
			# if it was missing and now it's correct, change the color
			modulate = color_correct
			btn_state = new_state
		elif new_state == 'present':
			# if it was missing and now it's present, change the color
			modulate = color_present
			btn_state = new_state
		# modulate = Color(1, 0, 0)

	elif btn_state == 'base':
		if new_state == 'correct':
			# if it was base and now it's correct, change the color
			modulate = color_correct
			btn_state = new_state
		elif new_state == 'present':
			# if it was base and now it's present, change the color
			modulate = color_present
			btn_state = new_state
		elif new_state == 'missing':
			# if it was base and now it's missing, change the color
			modulate = color_missing
			btn_state = new_state
		else:
			# it was base and it's still base
			modulate = color_base

func _on_button_down():
	# print a message to the console
	print()
	print('kb_btn: Button pressed: ' + btn_content)
	# # disable the button
	# self.disabled = true

	# emit a signal
	# emit_signal('kb_button_down', btn_content)
	kb_button_down.emit(btn_content)
