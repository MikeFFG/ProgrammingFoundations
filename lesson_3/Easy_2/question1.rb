ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

p ages.include?("Spot")

p ages.any? { |word| word == "Spot"}

p ages.has_key?("Spot")