class_name Guess
extends HBoxContainer

const guess_letter_scene: PackedScene = preload ("res://guess_letter.tscn")

# hold the guess letters in a list
var guess_letters = []
var guess_len: int

static func new_guess(guess_len_: int):
	var guess = Guess.new()
	guess.guess_len = guess_len_
	return guess

func build_guess():
	for i in range(0, guess_len):
		var guess_letter = guess_letter_scene.instantiate()
		add_child(guess_letter)
		guess_letters.append(guess_letter)

# Called when the node enters the scene tree for the first time.
func _ready():
	build_guess()
