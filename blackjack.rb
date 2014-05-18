
require 'pry'

####################################################################################
# Helper functions
####################################################################################

def init_deck
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J','Q','K','A']
  suits = [ 'C', 'D', 'H', 'S' ]
  deck = values.product(suits)
end

def draw(num_cards, deck, hand)
  # take num_cards number of cards from "deck" deck to "hand" hand
  num_cards.times do
    card = deck.shift
    hand.push(card)
  # NOTE: Ideally also handles drawing from an empty deck, etc.
  end
end

def calc_hand(hand)
  value = 0
  total = 0
  ace = false # Ask about a better way...
  hand.each do |card|
    if card[0] == 'J' || card[0] == 'Q' || card[0] == 'K'
      value = 10
    elsif card[0] == 'A'
      value = 1
      ace = true
    else
      value = card[0].to_i
    end
    total += value
  end
  # aces count as 11 when it would be beneficial to do so
  if ace == true && total < 12
    total += 10
  end
  return total
end

def show_hands(hand, dealer_hand)
  puts "you have"
  puts hand.to_s + " => " + calc_hand(hand).to_s + " points\n"
  puts ""
  puts "dealer has"
  puts dealer_hand[0].to_s
  puts ""
end

def ask(hand)
  puts "You can choose to \n1) hit\n2) stay"
  gets.chomp.to_i
end

def win?(hand, dealer_hand)
  if calc_hand(hand) > 21
    false
  elsif calc_hand(dealer_hand) > 21
    true
  elsif calc_hand(hand) >= calc_hand(dealer_hand)
    true
  end
end

####################################################################################
# Gameplay
####################################################################################

#Initializing the game state
game_over = false
choice = nil
deck = init_deck
hand = []
dealer_hand = []

puts "shuffling..."
deck.shuffle

puts "dealing player two cards"
puts ""
draw(2, deck, hand)
draw(2, deck, dealer_hand)


# I think this loop could be refactored to be more rubyist
until choice == 2 || calc_hand(hand) > 20
  show_hands(hand, dealer_hand)
  choice = ask(hand)
  if choice == 1
    draw(1, deck, hand)
  end
end

# Game's over
puts "you have"
puts hand.to_s + " => " + calc_hand(hand).to_s + " points"
puts "dealer had"
puts dealer_hand.to_s + " => " + calc_hand(dealer_hand).to_s + " points"

if win?(hand, dealer_hand)
  puts "you win!"
else
  puts "you lose..."
end

