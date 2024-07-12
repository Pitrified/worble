class_name Utils

static func get_char_index(word: String, seek: String) -> int:
    for i in range(0, word.length()):
        if word[i] == seek:
            return i
    return - 1
