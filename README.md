# Worble

Brazilian wordle clone.

## Game scene

* game_board
    * guesses
        * guess
            * guess_letter
    * keyboard
        * kb_button

A guess row can be in one of the following states:
* filled
* current
* empty

A keyboard button can be in one of the following states:
* correct: green
* present: yellow
* missing: black
* base: gray

## Functionalities

* [x] Pressing a `guess_letter` button removes only that letter
* [x] Load word list from file
* [x] Button to clear guesses
