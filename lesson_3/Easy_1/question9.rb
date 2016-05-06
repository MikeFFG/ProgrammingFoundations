flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones.delete_if {|key, _| key != "Barney"}

flintstones = flintstones.flatten

p flintstones