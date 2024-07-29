class_name Guess
extends HBoxContainer

const guess_letter_scene: PackedScene = preload("res://guess_letter.tscn")

# hold the guess letters in a list
var guess_letters = []
var guess_len: int
var guess_state = 'empty'
var word: String
var current_slot = -1

var on_guess_letter_outcome: Callable

static func new_guess(
	guess_len_: int,
	on_guess_letter_outcome_: Callable
):
	var guess = Guess.new()
	guess.guess_len = guess_len_
	# build a placeholder string made of _ characters, with the same length as the word
	guess.word = '_'.repeat(guess_len_)

	# # If you need to get the path to this node
	# var guess_node_path = guess.get_path()
	# print("Guess node path: ", guess_node_path)

	guess.on_guess_letter_outcome = on_guess_letter_outcome_

	return guess

func build_guess():
	for i in range(0, guess_len):
		# var guess_letter = guess_letter_scene.instantiate()
		var gl = GuessLetter.new_guess_letter('_', 'base', i, _on_guess_letter_pressed)
		add_child(gl)
		guess_letters.append(gl)

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
		input_backspace()
	elif content == 'enter':
		print('guess: enter')
		return
	elif content == '.':
		print('guess: dot')
		input_letter(content)
	else:
		print('guess: letter')
		input_letter(content)

func input_backspace():
	print('had word: ' + word)
	if current_slot == -1:
		print('guess: No more backspaces')
		return
	word[current_slot] = '_'
	guess_letters[current_slot].set_content('_')
	current_slot -= 1
		
func input_letter(content: String):
	print('had word: ' + word)
	# find the first empty slot
	# by clicking a guess letter, the letter is eliminated from the word
	# so we need to find the first empty slot
	# MAYBE track the right one while removing the letter
	current_slot = word.find('_')
	print('current_slot: ' + str(current_slot))
	if current_slot == -1:
		print('guess: No more empty slots')
		return
	word[current_slot] = content
	guess_letters[current_slot].set_content(content)
	print('new word: ' + word)

func check_guess(secret_word: String) -> String:
	# check that we have no empty slots
	current_slot = word.find('_')
	if current_slot != -1:
		print('guess: still empty slots')
		return 'more_empty_slots'
	# check that there are no dots in the middle of the word
	if Words.is_word_valid_dots(word) == false:
		print('guess: invalid word, dots in the middle')
		return 'dots_in_word'
	# check that the guess word is the same as the secret word
	print('guess: guess word: ' + word, ' secret word: ' + secret_word)
	update_colors(secret_word)
	print('guess: guess word: ' + word, ' secret word: ' + secret_word, ' after update color')
	if word == secret_word:
		print('guesses: You win!')
		return 'win'
	else:
		print('guesses: Try again')
		return 'try_again'

func update_colors(secret_word: String):
	# make a copy of the guessed word
	var guess_word = word

	# first check all the correct letters and remove them
	for i in range(0, guess_len):
		var guessed_letter = guess_word[i]
		# the letter is in the right place
		if guessed_letter == secret_word[i]:
			guess_letters[i].set_letter_state('correct')
			secret_word[i] = '_'
			print('guess: correct letter ', guessed_letter, ' at ', i)
			guess_word[i] = '_'
			# emit a signal that this letter is correct
			print('guess: emitting signal outcome ', guessed_letter, ' is correct')
			# emit_signal('guess_letter_outcome', guessed_letter, 'correct')
			on_guess_letter_outcome.call(guessed_letter, 'correct')

	# then check all the present letters
	for i in range(0, guess_len):
		var guessed_letter = guess_word[i]
		if guessed_letter == '_':
			continue
		# the letter is in the word, but not in the right place
		var secret_word_index = secret_word.find(guessed_letter)
		if secret_word_index != -1:
			guess_letters[i].set_letter_state('present')
			secret_word[secret_word_index] = '_'
			print('guess: present letter ', guessed_letter, ' at ', i, ' and ', secret_word_index)
			on_guess_letter_outcome.call(guessed_letter, 'present')
			continue
		# the letter is not in the word
		guess_letters[i].set_letter_state('missing')
		on_guess_letter_outcome.call(guessed_letter, 'missing')
		print('guess: missing letter ', guessed_letter, ' at ', i)

func _on_guess_letter_pressed(letter_id: int):
	print('guess: letter pressed: ' + str(letter_id))
	if guess_state != 'current':
		print('guess: not current, ignoring letter press')
		return
	# remove the letter from the word
	word[letter_id] = '_'
	guess_letters[letter_id].set_content('_')
