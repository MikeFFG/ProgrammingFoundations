# Replace the word "important" with "urgent" in this string:

advice = "Few things in life are as important as house training your pet dinosaur."

advice_array = advice.split(' ')

word_index = advice_array.index("important")

advice_array[word_index] = "urgent"

advice = advice_array.join(' ')

puts advice