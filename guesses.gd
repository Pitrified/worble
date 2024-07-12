class_name Guesses
extends VBoxContainer

func build_guesses():
	var guesses_num = 3
	for i in range(0, guesses_num):
		var guess = Guess.new_guess(5)
		add_child(guess)

# Called when the node enters the scene tree for the first time.
func _ready():
	build_guesses()
