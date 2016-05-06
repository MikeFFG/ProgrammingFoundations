# Programmatically determine if 42 lies between 10 and 100.
# hint: Use Ruby's range object in your solution.

(10...100).each do |i|
  if i == 42
    puts "42 is between 10 and 100"
    break
  end
end
