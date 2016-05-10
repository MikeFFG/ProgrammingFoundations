statement = "The Flintstones Rock"


# iterate through string by char
# check if hash has letter as key
# if so += 1
# if not add to hash

count = {}

statement.each_char do |n|
  if count.has_key?(n)
    count[n] += 1
  else
    count[n] = 1
  end
end

p count