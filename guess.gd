class_name Guess
extends HBoxContainer

const guess_letter_scene: PackedScene = preload ("res://guess_letter.tscn")

# hold the guess letters in a list
var guess_letters = []
var guess_len: int
var guess_state = 'empty'
var word: String
var current_slot = -1

static func new_guess(guess_len_: int):
	var guess = Guess.new()
	guess.guess_len = guess_len_
	# build a placeholder string made of _ characters, with the same length as the word
	guess.word = '_'.repeat(guess_len_)
	return guess

func build_guess():
	for i in range(0, guess_len):
		var guess_letter = guess_letter_scene.instantiate()
		add_child(guess_letter)
		guess_letters.append(guess_letter)

# Called when the node enters the scene tree for the first time.
func _ready():
	build_guess()

# func reset_guess():
# 	for guess_letter in guess_letters:
# 		guess_letter.reset_guess_letter()
# 	guess_state = 'empty'

func keyboard_input(content: String):
	print('guess: Button pressed: ' + content)
	if content == 'backspace':
		print('guess: backspace')
		add_backspace()
	elif content == 'enter':
		print('guess: enter')
		return
	else:
		print('guess: letter')
		add_letter(content)

func add_backspace():
	print('had word: ' + word)
	if current_slot == - 1:
		print('guess: No more backspaces')
		return
	word[current_slot] = '_'
	guess_letters[current_slot].set_content('_')
	current_slot -= 1
		
func add_letter(content: String):
	print('had word: ' + word)
	# find the first empty slot
	# by clicking a guess letter, the letter is eliminated from the word
	# so we need to find the first empty slot
	# MAYBE track the right one while removing the letter
	current_slot = Utils.get_char_index(word, '_')
	print('current_slot: ' + str(current_slot))
	if current_slot == - 1:
		print('guess: No more empty slots')
		return
	word[current_slot] = content
	guess_letters[current_slot].set_content(content)
	print('new word: ' + word)