# rock_paper_scissors_lizard_spock.rb

# Constants

VALID_CHOICES_HASH = {'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'l' => 'lizard', 'sp' => 'spock'}
OPTIONS = %w(rock paper scissors lizard spock)

# Variables

choice_string = <<-MSG 
Choose one:
        r for Rock
        p for Paper
        sc for Scissors
        l for Lizard
        sp for Spock
MSG

score = { "player" => 0, "computer" => 0 }

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

def display_results(player, computer, score)
  if win?(player, computer)
    prompt("You won this round!")
  elsif win?(computer, score)
    prompt("Computer won this round!")
  else
    prompt("It's a tie!")
  end
end

def keep_score(player, computer, current_score)
  if win?(player, computer)
    current_score["player"] += 1
  elsif win?(computer, player)
    current_score["computer"] += 1
  end
end

def clear()
  system "clear"
end

# Main Loop
loop do

  prompt("Welcome to Rock Paper Scissors Lizard Spock.")
  prompt("First player to 5 points wins!")

  # Single Game Loop
  loop do

    player_choice = ''

    loop do

      prompt(choice_string)
      choice = gets.chomp.downcase

      if VALID_CHOICES_HASH.include?(choice)
        choice = VALID_CHOICES_HASH[choice]
        break
      else
        clear
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = OPTIONS.sample

    clear

    puts("You chose: #{player_choice}; Computer chose: #{computer_choice}")

    display_results(player_choice, computer_choice, score)
    keep_score(player_choice, computer_choice, score)

    prompt("Current score is:\n Player: #{score[:player]} \n Computer: #{score[:computer]}")

    # Play again automatically unless someone reaches 5 points
    if score[:player] == 5
      prompt("You reached 5 points and won!")
    elsif score[:computer] == 5
      prompt("Computer reached 5 points and won :(")
    else
      next
    end

    break
  end

  # Play again?

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')

  clear
end

prompt("Thank you for playing. Goodbye!")
