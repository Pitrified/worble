extends Node

@export var kb_btn_scene: PackedScene

# define the keyboard letters, organized in rows
const KB_LETTERS = [
	['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
	['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
	['.', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'enter']
]

func build_keyboard():
	var x = 100
	var position_ = Vector2(x, 50)
	for row in KB_LETTERS:
		for letter in row:
			var kb_btn = KbButton.new_kb_button(letter, position_)
			# connect the signal
			kb_btn.connect('kb_button_down', _on_kb_button_kb_button_down)
			add_child(kb_btn)
			position_.x += 50
		position_.y += 50
		position_.x = x

# Called when the node enters the scene tree for the first time.
func _ready():
	build_keyboard()

func _on_kb_button_kb_button_down(content: String):
	print('board: Button pressed: ' + content)