class_name GameBoard
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

func start_game():
	# pick a random word
	var words = ['apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape', 'honeydew', 'kiwi', 'lemon', 'mango', 'nectarine', 'orange', 'papaya', 'quince', 'raspberry', 'strawberry', 'tangerine', 'watermelon']
	var word = words[randi() % words.size()]
	print('game_board: The word is: ' + word)
	# reset the guesses
	$Guesses.start_game(word)

func _on_keyboard_keyboard_input(content: String):
	print('game_board: Button pressed: ' + content)
	$Guesses.keyboard_input(content)
