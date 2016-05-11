def create_UUID
  my_array = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0)
  my_return_value = ''
  (1...32).each do
    my_return_value << my_array.sample.to_s
  end
  return my_return_value.to_s
end

p create_UUID