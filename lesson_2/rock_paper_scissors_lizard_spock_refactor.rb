# rock_paper_scissors_lizard_spock.rb

VALID_CHOICES_HASH = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors', 'l' => 'lizard', 'sp' => 'spock' }
WINS = {
  'rock' => %w(scissors lizard),
  'paper' => %w(rock spock),
  'scissors' => %w(paper lizard),
  'lizard' => %w(paper spock),
  'spock' => %w(rock scissors)
}

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  WINS[first].include?(second)
end

def calculate_winner(choices)
  if win?(choices[:player], choices[:computer])
    return :player
  elsif win?(choices[:computer], choices[:player])
    return :computer
  else
    return :tie
  end
end

def calculate_score(score, winner)
  if winner == :player
    score[:player] += 1
  elsif winner == :computer
    score[:computer] += 1
  end
  score
end

def clear_screen
  system('clear') || system('cls')
end

def display_round_winner(winner)
  if winner == :player
    prompt("You won this round!")
  elsif winner == :computer
    prompt("Computer won this round...")
  else
    prompt("This round is a tie.")
  end
  prompt("")
end

def display_game_winner(score)
  if score[:player] == 5
    prompt("You won the game!!!")
    prompt("")
  elsif score[:computer] == 5
    prompt("Sorry you lost!!! :(")
    prompt("")
  end
end

def display_score(score, final)
  if final == "final"
    prompt("Final score is:")
  else
    prompt("Current score is:")
  end
  prompt("Player: #{score[:player]}")
  prompt("Computer: #{score[:computer]}")
  prompt("")
end

def display_message_string
  message_string = <<-MSG
Choose one:
   r for Rock
   p for Paper
   sc for Scissors
   l for Lizard
   sp for Spock
  MSG
  prompt(message_string)
end

def get_player_choice(possible_choices)
  choice = ''

  loop do
    display_message_string
    choice = gets.chomp.downcase
    if possible_choices.include?(choice)
      choice = possible_choices[choice]
      break
    else
      clear_screen
      prompt("That's not a valid choice.")
    end
  end
  choice
end

def get_computer_choice(possible_choices)
  possible_choices.values.sample
end

def play_single_round(possible_choices)
  choices = {}
  choices[:player] = get_player_choice(possible_choices)
  choices[:computer] = get_computer_choice(possible_choices)
  choices
end

def play_again?
  loop do
    answer = gets.chomp
    if answer.casecmp('y') == 0
      return 'y'
    elsif answer.casecmp('n') == 0
      return 'n'
    else
      prompt("Please type y or n only.")
    end
  end
end

clear_screen
prompt("Welcome to Rock Paper Scissors Lizard Spock.")
prompt("")

loop do
  prompt("First player to 5 points wins!")
  prompt("")

  current_score = { player: 0, computer: 0 }

  loop do
    choices = play_single_round(VALID_CHOICES_HASH)
    clear_screen
    prompt("You chose: #{choices[:player]}; Computer chose: #{choices[:computer]}")
    prompt("")

    winner = calculate_winner(choices)
    current_score = calculate_score(current_score, winner)

    if current_score[:player] == 5 || current_score[:computer] == 5
      prompt("Game Over")
      prompt("")
      display_game_winner(current_score)
      display_score(current_score, "final")
      break
    end

    display_score(current_score, "")
  end

  prompt("Do you want to play again? Type y for yes or n for no.")
  break if play_again? == 'n'

  clear_screen
end

clear_screen
prompt("Thank you for playing. Goodbye!")
