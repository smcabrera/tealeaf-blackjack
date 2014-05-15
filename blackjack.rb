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



# deck
  # A deck is made up of 52 cards. 
# cards
  # A card is made up of a number and a suit 
  # Suits are H, D, C, S 
  # Numbers are ['2, 3, 4, 5, 6, 7, 8, 9, 10, 'J','Q','K','A']




####################################################################################
# Helper functions 
####################################################################################

# I need a method that handles keeping track of total value of cards, or actually just a variable that gets updated
def calc_hand(hand)
  # Inputs a hand of cards (suit value pairs of the kind listed above) and caluclates their value.
  value = 0
  hand.each do |card|
    if card[0] == 'J' || 'Q' || 'K'
      value = 10
    elsif card[0] == 'A'
      value = 1
    else
      value = card[0].to_i
      
              
end

 
def draw(num_cards, deck, hand)
  # adds num_cards number of cards from "deck" deck to "hand" hand 
  num_cards.times do
    card = deck[rand(deck.length)]
    hand.push(card)
    deck.delete(card)
  
  # NOTE: Ideally you'd want to handle situations like draw from an empty deck, etc. 

  end
end

def shuffle
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

deck = shuffle
hand = []
draw(2, deck, hand)




binding.pry



####################################################################################
# Gameplay 
####################################################################################




# Deal two cards (write deal method and then call it here)
#After being dealt the initial 2 cards, the player goes first and can choose to either "hit" or "stay". 

# if hit then hit again

# if stay then game ends and you decide who wins

#

#If the player's cards sum up to be greater than 21, the player has "busted" and lost


# I need a method that handles dealing an initial hand
# I need a method that handles dealing 


@player_score = nil
@dealer_score = nil

def hit()

end


def end_game()

end








