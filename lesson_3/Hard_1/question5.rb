def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  if dot_separated_words.size > 0 || dot_separated_words.size < 5
    while dot_separated_words.size > 0 do
      word = dot_separated_words.pop
      break if !is_a_number?(word)
    end
    return true
  else
    return false
  end
end