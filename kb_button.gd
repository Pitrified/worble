class_name KbButton
extends Button

# if it breaks, use the commented local version
const my_scene: PackedScene = preload ('res://kb_button.tscn')

# signal button_down
signal kb_button_down(content: String)

var btn_content: String = ''

# a map to show the user a different character for some keys
const SHOW_CHARS = {
	'enter': '↵',
	'backspace': '⌫',
	'.': '.',
}

# kinda constructor
# https://www.reddit.com/r/godot/comments/13pm5o5/instantiating_a_scene_with_constructor_parameters/
static func new_kb_button(content: String, position_: Vector2) -> KbButton:
	# var my_scene: PackedScene = load('res://kb_button.tscn')
	var kb_btn: KbButton = my_scene.instantiate()
	# set the button content
	kb_btn.btn_content = content
	# set the button text shown to the user
	kb_btn.text = SHOW_CHARS.get(content, content)
	# set the button position
	kb_btn.position = position_
	# # connect the signal to the receiver method
	# kb_btn.connect('kb_button_down', _on_button_down)
	return kb_btn

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_down():
	# print a message to the console
	print('kb_btn: Button pressed: ' + btn_content)
	# # disable the button
	# self.disabled = true

	# emit a signal
	# emit_signal('kb_button_down', btn_content)
	kb_button_down.emit(btn_content)
