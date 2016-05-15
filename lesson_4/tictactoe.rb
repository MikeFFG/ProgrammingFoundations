require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
THREATENING_LINES = [[1, 2], [2, 3], [4, 5], [5, 6], [7, 8], [8, 9]] +
                    [[1, 4], [4, 7], [2, 5], [5, 8], [3, 6], [6, 9]] +
                    [[1, 5], [5, 9], [3, 5], [5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def valid_choice_prompt
  prompt "Sorry, that's not a valid choice."
end

def clear_screen
  system('clear') || system('cls')
end

def joinor(ary, dlm = ',', word = 'or')
  new_string = ''
  ary.each_index do |num|
    new_string += if num == ary.length - 1
                    "#{word} #{ary[num]}"
                  else
                    "#{ary[num]}#{dlm} "
                  end
  end
  new_string
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  clear_screen
  puts "You're an #{PLAYER_MARKER}. Computer is an #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

# rubocop:enable Metrics/AbcSize
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == ' ' }.keys.first
  end
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return :player
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return :computer
    end
  end
  nil
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd), ',', 'or')}."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    valid_choice_prompt
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  if !square && empty_squares(brd).include?(5)
    square = 5
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def display_current_score(score)
  prompt "Current Score -  Player: #{score[:player]}. " \
         "Computer: #{score[:computer]}."
  prompt ""
end

loop do
  prompt "Welcome to Tic Tac Toe!"
  prompt "First player to win 5 rounds wins the game!"

  current_score = { player: 0, computer: 0 }
  continue_game = 'n'

  loop do
    board = initialize_board

    loop do
      display_board(board)
      display_current_score(current_score)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      prompt "#{detect_winner(board).capitalize} won the round!"
      current_score[detect_winner(board)] += 1
    else
      prompt "It's a tie!"
    end

    display_current_score(current_score)

    break if current_score[:player] == 5 || current_score[:computer] == 5

    loop do
      prompt "Ready for the next round? (y or n)"
      continue_game = gets.chomp.downcase
      break if continue_game == 'y' || continue_game == 'n'
      valid_choice_prompt
    end
    break unless continue_game.casecmp('y') == 0
  end

  clear_screen

  if continue_game == 'n'
    prompt "Game cancelled..."
    break
  end

  prompt "Game Over!"
  prompt "#{current_score.key(5).capitalize} won the game!!!!"
  prompt ""

  answer = ''
  loop do
    prompt "Play new game? (y or n)"
    answer = gets.chomp
    break if answer == 'y' || answer == 'n'
    valid_choice_prompt
  end
  break unless answer.casecmp('y') == 0
end

prompt "Thanks for playing Tic Tac Toe! Buh-bye!"
