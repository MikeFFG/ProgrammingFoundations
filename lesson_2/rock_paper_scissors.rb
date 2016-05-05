# rock_paper_scissors.rb

# Constants

VALID_CHOICES_HASH = {'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'l' => 'lizard', 'sp' => 'spock'}
OPTIONS = %w(rock paper scissors lizard spock)

# Variables

$score = [0, 0] # player is 1st and computer is second

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
    keep_score('player')
  elsif win?(computer, player)
    prompt("Computer won this round!")
    keep_score('computer')
  else
    prompt("It's a tie!")
  end
end

def keep_score(round_winner)
  if round_winner == 'player'
    $score[0] += 1
  elsif round_winner == 'computer'
    $score[1] += 1
  end
end

# Main Loop
loop do

  # Single Game Loop
  loop do

    choice = ''

    loop do
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

      if VALID_CHOICES_HASH.include?(choice)
        choice = VALID_CHOICES_HASH[choice]
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = OPTIONS.sample

    puts("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)

    prompt("Current score is:\n Player: #{$score[0]} \n Computer: #{$score[1]}")

    # Play again automatically unless someone reaches 5 points
    if $score[0] == 5
      prompt("You reached 5 points and won!")
    elsif $score[1] == 5
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

  # reset score
  $score = [0,0]
end

prompt("Thank you for playing. Goodbye!")
