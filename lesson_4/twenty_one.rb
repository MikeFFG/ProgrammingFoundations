require 'pry'

SUITS = ['Hearts', 'Spades', 'Clubs', 'Diamonds'].freeze
VALUES = ['A', '2', '3', '4', '5', '6', '7'] +
         ['8', '9', '10', 'J', 'Q', 'K'].freeze
DEALER_STAY_VALUE = 17
WIN_VALUE = 21

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def clear_screen
  system('clear') || system('cls')
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i == 0 # J, Q, K
             10
           else
             value.to_i
           end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > WIN_VALUE
  end

  sum
end

def deal_cards(deck)
  new_hand = deck.shift(4)
  player_hand = [new_hand[0], new_hand[2]]
  dealer_hand = [new_hand[1], new_hand[3]]
  [player_hand, dealer_hand]
end

def player_choice
  loop do
    prompt "Hit or stay? (h or s)"
    answer = gets.chomp
    if answer.casecmp('h') == 0
      return 'hit'
    elsif answer.casecmp('s') == 0
      return 'stay'
    else
      prompt "Please type h or s only."
    end
  end
end

def busted?(cards)
  total(cards) > WIN_VALUE
end

def hits!(hand, deck)
  hand << deck.shift
end

def detect_result(player_cards, dealer_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > WIN_VALUE
    :player_busted
  elsif dealer_total > WIN_VALUE
    :dealer_busted
  elsif player_total > dealer_total
    :player_wins
  elsif dealer_total > player_total
    :dealer_wins
  else
    :tie
  end
end

def play_again?
  loop do
    prompt "Play again? (y or n)"
    answer = gets.chomp
    if answer.casecmp('y') == 0
      return 'y'
    elsif answer.casecmp('n') == 0
      return 'n'
    else
      prompt "Please type y or n only."
    end
  end
end

def update_score(score, player_cards, dealer_cards)
  result = detect_result(player_cards, dealer_cards)
  case result
  when :player_busted
    score[:dealer] += 1
  when :dealer_busted
    score[:player] += 1
  when :player_wins
    score[:player] += 1
  when :dealer_wins
    score[:dealer] += 1
  end
  score
end

# Display methods
def display_initial_hands(player_hand, dealer_hand)
  prompt "Dealer has: #{dealer_hand[0]} and unknown card"
  prompt "You have: #{player_hand[0]} and #{player_hand[1]}"
end

def display_player_hand(player_hand)
  prompt "Your cards are: #{player_hand}"
  prompt "Your total is: #{total(player_hand)}"
end

def display_dealer_hand(dealer_hand)
  prompt "Dealer's cards are: #{dealer_hand}"
  prompt "Dealer's total is: #{total(dealer_hand)}"
end

def display_hand_comparison(player_hand, dealer_hand)
  puts "=============="
  prompt "Dealer has #{dealer_hand}, for a total of: #{total(dealer_hand)}"
  prompt "Player has #{player_hand}, for a total of: #{total(player_hand)}"
  puts "=============="
  display_result(player_hand, dealer_hand)
end

def display_current_score(score)
  prompt "Current Score -  Player: #{score[:player]}. " \
         "Dealer: #{score[:dealer]}."
  prompt ""
end

def display_result(player_cards, dealer_cards)
  result = detect_result(player_cards, dealer_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins round."
  when :dealer_busted
    prompt "Dealer busted! You win the round!"
  when :player_wins
    prompt "You win round!"
  when :dealer_wins
    prompt "Dealer won the round :("
  when :tie
    prompt "Push!"
  end
end

def winner?(score)
  if score[:player] >= 5
    :player
  elsif score[:dealer] >= 5
    :dealer
  end
end

loop do
  current_score = { player: 0, dealer: 0 }
  clear_screen
  prompt "Welcome to Twenty-One!"
  prompt "First player to win 5 rounds wins the game!"
  prompt ""
  prompt "Ready to play? Press any key to continue."
  answer = gets.chomp

  loop do # Single Game Loop
    clear_screen
    current_deck = initialize_deck
    player_hand, dealer_hand = deal_cards(current_deck)
    display_initial_hands(player_hand, dealer_hand)
    prompt "Your total is: #{total(player_hand)}"

    loop do # Player Turn Loop
      hit_or_stay = player_choice

      if hit_or_stay == 'hit'
        clear_screen
        player_hand = hits!(player_hand, current_deck)
        prompt "You chose to hit!"
        display_player_hand(player_hand)
      end
      break if busted?(player_hand) || hit_or_stay == 'stay'
    end

    if busted?(player_hand)
      display_hand_comparison(player_hand, dealer_hand)
      current_score = update_score(current_score, player_hand, dealer_hand)
      display_current_score(current_score)
      if winner?(current_score)
        break
      else
        prompt "Ready for the next round? Press any key to continue."
        answer = gets.chomp
        next
      end
    end

    clear_screen

    prompt "Dealer's turn now."
    display_dealer_hand(dealer_hand)

    loop do # Dealer Turn Loop
      break if busted?(dealer_hand) || total(dealer_hand) >= DEALER_STAY_VALUE

      prompt "Dealer hits!"
      dealer_hand << current_deck.shift
      display_dealer_hand(dealer_hand)
    end

    if busted?(dealer_hand)
      display_hand_comparison(player_hand, dealer_hand)
      current_score = update_score(current_score, player_hand, dealer_hand)
      display_current_score(current_score)
      if winner?(current_score)
        break
      else
        prompt "Ready for the next round? Press any key to continue."
        answer = gets.chomp
        next
      end
    end

    prompt "Dealer stays."

    # both player and dealer stays - compare cards!
    display_hand_comparison(player_hand, dealer_hand)
    current_score = update_score(current_score, player_hand, dealer_hand)
    display_current_score(current_score)
    if winner?(current_score)
      break
    else
      prompt "Ready for the next round? Press any key to continue."
      answer = gets.chomp
      next
    end
  end
  prompt "Game Over!"
  prompt "#{winner?(current_score).capitalize} wins the game!"
  prompt ""

  break unless play_again? == 'y'
end

prompt "Thanks for playing! Bye!"
