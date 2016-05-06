# Starting with the string, show two different ways to put the expected "Four score and " in front of it.

famous_words = "seven years ago..."

# first

puts famous_words.insert(0, "Four score and ")

# reset

famous_words = "seven years ago..."

# second

puts famous_words.prepend("Four score and ")