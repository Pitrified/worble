extends Node

@export var kb_btn_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var kb_btn = kb_btn_scene.instantiate()
	kb_btn.position = Vector2(50, 50)
	kb_btn.btn_content = 'B'
	add_child(kb_btn)

	var position_ = Vector2(100, 50)
	var kb_btn2 = KbButton.new_kb_button('C', position_)
	# connect the signal
	kb_btn2.connect('kb_button_down', _on_kb_button_kb_button_down)
	add_child(kb_btn2)

func _on_kb_button_kb_button_down(content: String):
	print('board: Button pressed: ' + content)
