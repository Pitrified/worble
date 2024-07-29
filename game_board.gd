class_name GameBoard
extends Control

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

func _on_guesses_guess_letter_outcome(letter: String, state: String):
	print('game_board: guess letter outcome: ', letter, state)
	$Keyboard.on_letter_state_update(letter, state)
