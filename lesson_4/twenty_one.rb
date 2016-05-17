require 'pry'

SUITS = ['Hearts', 'Spades', 'Clubs', 'Diamonds'].freeze
VALUES = ['A', '2', '3', '4', '5', '6', '7'] +
         ['8', '9', '10', 'J', 'Q', 'K'].freeze

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
    sum -= 10 if sum > 21
  end

  sum
end

def deal_cards(deck)
  new_hand = deck.shift(4)
  player_hand = [new_hand[0], new_hand[2]]
  dealer_hand = [new_hand[1], new_hand[3]]
  [player_hand, dealer_hand]
end

def display_initial_hands(player_hand, dealer_hand)
  prompt "Dealer has: #{dealer_hand[0]} and unknown card"
  prompt "You have: #{player_hand[0]} and #{player_hand[1]}"
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
  total(cards) > 21
end

def hits!(hand, deck)
  hand << deck.shift
end

def detect_result(player_cards, dealer_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif player_total > dealer_total
    :player_wins
  elsif dealer_total > player_total
    :dealer_wins
  else
    :tie
  end
end

def display_result(player_cards, dealer_cards)
  result = detect_result(player_cards, dealer_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins."
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player_wins
    prompt "You win!"
  when :dealer_wins
    prompt "Dealer won :("
  when :tie
    prompt "Push!"
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

loop do # Single Game Loop
  current_deck = initialize_deck
  player_hand, dealer_hand = deal_cards(current_deck)
  loop do # Player Turn Loop
    clear_screen
    display_initial_hands(player_hand, dealer_hand)
    prompt "Your total is: #{total(player_hand)}"
    hit_or_stay = player_choice

    if hit_or_stay == 'hit'
      clear_screen
      player_hand = hits!(player_hand, current_deck)
      prompt "You chose to hit!"
      prompt "Your cards are now: #{player_hand}"
      prompt "Your total is now: #{total(player_hand)}"
    end
    break if busted?(player_hand) || hit_or_stay == 'stay'
  end

  if busted?(player_hand)
    display_result(player_hand, dealer_hand)
    if play_again? == 'y'
      next
    else
      break
    end
  end

  clear_screen
  
  prompt "Dealer's turn now."

  loop do # Dealer Turn Loop
    break if busted?(dealer_hand) || total(dealer_hand) >= 17

    prompt "Dealer hits!"
    dealer_hand << current_deck.shift
    prompt "Dealer's cards are now: #{dealer_hand}"
  end

  if busted?(dealer_hand)
    display_result(player_hand, dealer_hand)
    if play_again? == 'y'
      next
    else
      break
    end
  end

  # both player and dealer stays - compare cards!
  puts "=============="
  prompt "Dealer has #{dealer_hand}, for a total of: #{total(dealer_hand)}"
  prompt "Player has #{player_hand}, for a total of: #{total(player_hand)}"
  puts "=============="

  display_result(dealer_hand, player_hand)

  break unless play_again? == 'y'
end

prompt "Thanks for playing! Bye!"
