
require 'pry'
require 'pp'
####################################################################################
# Classes
####################################################################################

class Card
  attr_accessor :suit, :rank, :rank_name, :suit_name

  def initialize(s, r)
    self.suit = s
    self.rank = r
  end

  def to_s
    "The #{rank_name} of #{suit_name}"
  end

  private

  def rank_name
    rank_symbol = self.rank.to_s.intern
    rank_names = {
    :'2'=> 'Two', :'3'=> 'Three', :'4'=> 'Four', :'5'=> 'Five',
    :'6'=> 'Six', :'7'=> 'Seven', :'8'=> 'Eight', :'9'=> 'Nine',
    :'10'=> 'Ten', :'j'=> 'Jack', :'q'=> 'Queen', :'k'=> 'King', :'a'=> 'Ace'
    }
    rank_names[rank_symbol]
  end

  def suit_name
    suit_symbol = self.suit.intern
    suit_names = {
      :'c'=>'Clubs', :'d'=> 'Diamonds', :'h'=> 'Hearts', :'s'=> 'Spades'}
    self.suit_name = suit_names[suit_symbol]
  end
end

mycard = Card.new('s', '2')
puts mycard


class Deck < Array
  # Based on an array; would it make sense to inherit from array?
  attr_accessor :cards
  def initialize
    @cards = []
    ranks = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'j','q','k','a']
    suits = [ 'c', 'd', 'h', 's' ]
    ranks.each do |rank|
      suits.each do |suit|
        @cards << Card.new(suit, rank)
      end
    end
    scramble!
  end

  def scramble!
    cards.shuffle!
  end

  def to_s
    self.cards
  end

  def deal
    cards.shift
  end
end

module Handable
  def calc_hand(hand)
    value = 0
    total = 0
    ace = false # ask about a better way...
    hand.each do |card|
      if card[0] == 'j' || card[0] == 'q' || card[0] == 'k'
        value = 10
      elsif card[0] == 'a'
        value = 1
        ace = true
      else
        value = card[0].to_i
      end
        total += value
    end
    # aces count as 11 when it would be beneficial to do so
    total += 10 if ace == true && total < 12
    total
  end

  def show_hand(hand, name)
    puts "#{name} has"
    puts "#{hand.to_s} => #{calc_hand(hand)} points\n''"
  end
end

class Player
  attr_accessor :hand

  include Handable

  def initialize(hand=[])
    self.hand = hand
  end
end

class Dealer
  attr_accessor :hand

  include Handable

  def initialize(hand=[])
    self.hand = hand
  end
end



binding.pry

exit

####################################################################################
# helper functions
####################################################################################

def ask(hand)
  puts "you can choose to \n1) hit\n2) stay"
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
# gameplay
####################################################################################

#initializing the game state
game_over = false
choice = nil
deck = init_deck
hand = []
dealer_hand = []

puts "shuffling..."
deck = init_deck.shuffle

#binding.pry

puts "dealing player two cards"
puts ""
draw(2, deck, hand)
draw(2, deck, dealer_hand)


# i think this loop could be refactored to be more rubyist
until choice == 2 || calc_hand(hand) > 20
  show_hands(hand, dealer_hand)
  choice = ask(hand)
  if choice == 1
    draw(1, deck, hand)
  end
end

# now for dealer
until calc_hand(dealer_hand) > 16
  show_hands(hand, dealer_hand)
  draw(1, deck, dealer_hand)
end

# game's over
puts "you have"
puts hand.to_s + " =>  #{calc_hand(hand)} points"
puts "dealer had"
puts dealer_hand.to_s + " => #{calc_hand(dealer_hand)} points"

if win?(hand, dealer_hand)
  puts "you win!"
else
  puts "you lose..."
end

# tasks; 1) add edge case of blackjack initial hand
# 3) simplifying your string concats
