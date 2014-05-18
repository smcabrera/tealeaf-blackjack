#
# Rules
####################################################################################

#Blackjack is a card game where you calculate the sum of the values of your cards and try to hit 21, aka "blackjack". Both the player and dealer are dealt two cards to start the game. All face cards are worth whatever numerical value they show. Suit cards are worth 10. Aces can be worth either 11 or 1. Example: if you have a Jack and an Ace, then you have hit "blackjack", as it adds up to 21.

#. If the sum is 21, then the player wins. If the sum is less than 21, then the player can choose to "hit" or "stay" again. If the player "hits", then repeat above, but if the player stays, then the player's total value is saved, and the turn moves to the dealer.

#By rule, the dealer must hit until she has at least 17. If the dealer busts, then the player wins. If the dealer, hits 21, then the dealer wins. If, however, the dealer stays, then we compare the sums of the two hands between the player and dealer; higher value wins.

####################################################################################
# data structures
####################################################################################

require 'pry'

# I need a data structure for the deck and its cards (these are easy to imagine as objects really).
  # We could either create a class straight away or we could do something where we create a hash mapping each card to its value...
  # We can start by writing the necessary methods on a mini-deck and we could then expand this later to be the methods that are part
  # of the class definition so that'll save time.
#

# cards
  # Suits are H, D, C, S
  # Numbers are ['2, 3, 4, 5, 6, 7, 8, 9, 10, 'J','Q','K','A']




####################################################################################
# Helper functions
####################################################################################

# I need a method that handles keeping track of total value of cards, or actually just a variable that gets updated
def calc_hand(hand)
  # Inputs a hand of cards (suit value pairs of the kind listed above) and caluclates their value.
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

def draw(num_cards, deck, hand)

  # adds num_cards number of cards from "deck" deck to "hand" hand
  num_cards.times do
    # Change this to use .pop and add randomization to shuffle
    card = deck[rand(deck.length)]
    hand.push(card)
    deck.delete(card)
  # NOTE: Ideally you'd want to handle situations like draw from an empty deck, etc.
  end
end

def shuffle
  # A deck is made up of 52 cards.
  # A card is made up of a value and a suit
  values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J','Q','K','A']
  suits = [ 'C', 'D', 'H', 'S' ]
  deck = []

  values.each do |value|
    suits.each do |suit|
      deck.push([value, suit])
    end
  end
  return deck
end


####################################################################################
# Gameplay
####################################################################################

# We need a player hand and a dealer hand and we need to play through their
# turns. Let's start with just the player and then extrapolate that logic to the dealer


# Deal two cards
#After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay".

puts "shuffling..."
hand = []
deck = shuffle
puts "dealing player two cards"
draw(2, deck, hand)

def ask
  puts "You can choose to \n1) hit\n2) stay?"
  gets.chomp.to_i
end

# While the game is going
# player gets asked to hit or stay

def game_over?(hand, choice)
  # game ends when player busts, hits 21 or stays
  if calc_hand(hand) > 20
    return true
  elsif choice == 2
    return true
  else
    return false
  end
end


game_over = false

until game_over
  if choice == 1
    puts choice = ask
    game_over?(hand, choice)
  elsif choice == 2
    puts "end game state"
    game_over?(hand, choice)
  else
    puts "invalid choice [reprompt]"
  end
end

binding.pry

# Method for determining who wins when game ends

