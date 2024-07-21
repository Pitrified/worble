class_name Keyboard
extends Control

# define the keyboard letters, organized in rows
const KB_LETTERS = [
	['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
	['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'backspace'],
	['.', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'enter']
]

var letters_board = []
var KB_LETTER_MARGIN = 10

signal keyboard_input(content: String)

func build_keyboard():
	print('building keyboard')

	# remove the previous keyboard
	remove_keyboard()
	print('keyboard removed, rebuilding')

	# compute the width available
	var cur_size = get_size()
	var width_available = cur_size.x
	var position_ = Vector2(0, 0)
	var letter_height = 70

	for row in KB_LETTERS:
		var letters_row = []

		# based on the number of letters in the row, compute the width of each letter
		var num_letters = row.size()
		var width_available_for_letters = width_available - (num_letters - 1) * KB_LETTER_MARGIN
		var letter_width = width_available_for_letters / num_letters

		for letter in row:
			# create a button for each letter
			var kb_btn = KbButton.new_kb_button(letter, _on_kb_button_kb_button_down)
			add_child(kb_btn)

			# set the size and position of the button
			kb_btn.set_size(Vector2(letter_width, letter_height))
			kb_btn.set_position(position_)
			# move to the next position
			position_.x += letter_width + KB_LETTER_MARGIN

			letters_row.append(kb_btn)

		# move to the next row
		position_.y += letter_height + KB_LETTER_MARGIN
		position_.x = 0
		letters_board.append(letters_row)
 
# func update_keyboard():
# 	print('start updating keyboard')
# 	var position_ = Vector2(0, 50)
# 	print('position_', position_)
# 	var cur_size = get_size()
# 	var width_available = cur_size.x
# 	for row in letters_board:
# 		var num_letters = row.size()
# 		var width_available_for_letters = width_available - (num_letters - 1) * KB_LETTER_MARGIN
# 		var letter_width = width_available_for_letters / num_letters
# 		for letter in row:
# 			letter.set_size(Vector2(letter_width, 50))
# 			letter.set_position(position_)
# 			position_.x += letter_width + KB_LETTER_MARGIN
# 		position_.y += 50 + KB_LETTER_MARGIN
# 		position_.x = 0

func remove_keyboard():
	print('removing keyboard')
	for row in letters_board:
		print('removing row')
		for letter in row:
			print('removing letter')
			# remove_child(letter) # is this needed?
			letter.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	build_keyboard()

func _on_kb_button_kb_button_down(content: String):
	print('board: Button pressed: ' + content)
	emit_signal('keyboard_input', content)

func _notification(what):
	match what:
		NOTIFICATION_MOUSE_ENTER:
			pass # Mouse entered the area of this control.
		NOTIFICATION_MOUSE_EXIT:
			pass # Mouse exited the area of this control.
		NOTIFICATION_FOCUS_ENTER:
			pass # Control gained focus.
		NOTIFICATION_FOCUS_EXIT:
			pass # Control lost focus.
		NOTIFICATION_THEME_CHANGED:
			pass # Theme used to draw the control changed;
			# update and redraw is recommended if using a theme.
		NOTIFICATION_VISIBILITY_CHANGED:
			pass # Control became visible/invisible;
			# check new status with is_visible().
		NOTIFICATION_RESIZED:
			pass # Control changed size; check new size
			# with get_size().
			print('board: resized', get_size())
			# build_keyboard()
