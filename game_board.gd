class_name GameBoard
extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

func start_game():
	# pick a random word
	var word = Words.get_random_word()
	print('game_board: The word is: ' + word)
	# reset the guesses
	$Guesses.start_game(word)

func _on_keyboard_keyboard_input(content: String):
	print('game_board: Button pressed: ' + content)
	$Guesses.keyboard_input(content)
