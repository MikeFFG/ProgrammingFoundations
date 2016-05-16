# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

require 'pry'

SUITS = ['H', 'S', 'C', 'D'].freeze
VALUES = ['A', '2', '3', '4', '5', '6', '7'] +
         ['8', '9', '10', 'J', 'Q', 'K'].freeze

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == "A"
      sum += 11
    elsif value.to_i == 0 # J, Q, K
      sum += 10
    else
      sum += value.to_i
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
  return player_hand, dealer_hand
end

def display_hands(player_hand, dealer_hand)
  prompt "Dealer has: #{dealer_hand[0][1]} and unknown card"
  prompt "You have: #{player_hand[0][1]} and #{player_hand[1][1]}"
end

def hit_or_stay
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

loop do
  current_deck = initialize_deck

  player_hand, dealer_hand = deal_cards(current_deck)

  display_hands(player_hand, dealer_hand)

  p player_hand
  p total(player_hand)
end