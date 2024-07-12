class_name Guesses
extends VBoxContainer

var secret_word: String

var guesses_ls = []
var current_guess_id = 0
var current_guess: Guess

const guesses_num = 6

func build_guesses():
	var secret_word_len = secret_word.length()
	for i in range(0, guesses_num):
		var guess = Guess.new_guess(secret_word_len)
		add_child(guess)
		guesses_ls.append(guess)

func keyboard_input(content: String):
	print('guesses: Button pressed: ' + content)
	current_guess.keyboard_input(content)
	if content == 'enter':
		print('guesses: enter')
		input_enter()

func input_enter():
	var outcome = current_guess.check_guess(secret_word)
	# if the word was correct or there were empty slots, we can continue
	if outcome == 'more_empty_slots':
		return
	elif outcome == 'win':
		pass
		# game over, won
	# try to go to the next guess
	current_guess_id += 1
	if current_guess_id < guesses_num:
		# TODO probably need to use a set_guess_state to also update colors and stuff
		current_guess.guess_state = 'empty'
		current_guess = guesses_ls[current_guess_id]
		current_guess.guess_state = 'current'
	else:
		print('guesses: No more guesses')
		# game over, lost

func start_game(word: String):
	print('guesses: The word is: ' + word)
	# save the secret word
	secret_word = word
	# delete all existing guesses instances
	for guess in guesses_ls:
		# remove_child(guess) # is this needed?
		guess.queue_free()
	# create new guesses instances
	build_guesses()
	# set the first guess as current
	current_guess_id = 0
	current_guess = guesses_ls[current_guess_id]
	current_guess.guess_state = 'current'
