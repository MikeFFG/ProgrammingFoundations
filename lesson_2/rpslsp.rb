# rock_paper_scissors_lizard_spock.rb

# Constants

VALID_CHOICES_HASH = {'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'l' => 'lizard', 'sp' => 'spock'}

# Methods

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'spock' && second == 'rock') ||
    (first == 'spock' && second == 'scissors')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won this round!")
  elsif win?(computer, player)
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

def clear_screen
  system('clear') || system('cls')
end

def display_score(score)

end

def get_player_choice(possible_choices)

  message_string = <<-MSG 
  Choose one:
          r for Rock
          p for Paper
          sc for Scissors
          l for Lizard
          sp for Spock
  MSG
  prompt(message_string)
  choice = gets.chomp.downcase

  loop do
    if possible_choices.include?(choice)
      choice = possible_choices(choice)
    else
      clear_screen
      prompt("That's not a valid choice.")
    end    
  end

  return choice
end

def get_computer_choice(possible_choices)
  computer_choice = possible_choices.values.sample
  return computer_choice
end


def play_single_round(possible_choices, score)
  clear_screen
  player_choice = get_player_choice(possible_choices)
  computer_choice - get_computer_choice(possible_choices)
  puts("You chose: #{player_choice}; Computer chose: #{computer_choice}")
  display_results(player_choice, computer_choice)
end

loop do

  prompt("Welcome to Rock Paper Scissors Lizard Spock.")
  prompt("First player to 5 points wins!")

  current_score = { player: "0", computer: "0" }

  loop do

    play_single_round(VALID_CHOICES_HASH, current_score)

    break
  end

  # Play again?

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')

  clear_screen
end

prompt("Thank you for playing. Goodbye!")
