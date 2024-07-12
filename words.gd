class_name Words

const words: Array[String] = ['apple', 'banana', 'cherry', 'date', 'elderberry', 'fig', 'grape', 'honeydew', 'kiwi', 'lemon', 'mango', 'nectarine', 'orange', 'papaya', 'quince', 'raspberry', 'strawberry', 'tangerine', 'watermelon']

static func get_random_word() -> String:
    return words[randi() % words.size()].to_upper()

static func strip_edges(word: String, seek: String) -> String:
    var start = 0
    var end = word.length()
    for i in range(0, word.length()):
        if word[i] == seek:
            start += 1
        else:
            break
    for i in range(word.length() - 1, -1, -1):
        if word[i] == seek:
            end -= 1
        else:
            break
    var clean_word = word.substr(start, end - start)
    print('strip_edges: ' + word + ' -> ' + clean_word)
    return clean_word

static func is_word_valid_dots(word: String) -> bool:
    var clean_word = strip_edges(word, '.')
    var dot_index = clean_word.find('.')
    if dot_index != - 1:
        return false
    return true