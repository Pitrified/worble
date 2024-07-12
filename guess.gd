class_name Guess
extends HBoxContainer

@export var guess_letter_scene: PackedScene = preload ("res://guess_letter.tscn")

# hold the guess letters in a list
var guess_letters = []

func build_guess(guess_len: int):
	for i in range(0, guess_len):
		var guess_letter = guess_letter_scene.instantiate()
		add_child(guess_letter)
		guess_letters.append(guess_letter)

# Called when the node enters the scene tree for the first time.
func _ready():
	build_guess(5)
