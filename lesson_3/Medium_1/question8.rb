
def titleize(word)
  split_words = word.split(' ')
  combined_words = ''
  split_words.each do |n| 
    n.capitalize!
    combined_words += n + " "
  end
  combined_words.rstrip
end

p titleize("Radiohead's new album is pretty SWEET!!!!")