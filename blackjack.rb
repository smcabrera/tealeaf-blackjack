require 'pry'
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


class Deck
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
    deck_string = ""
    cards.each do |card|
      deck_string += " #{card} "
    end
    deck_string
  end

  def deal
    cards.shift
  end
end

module Handable
  attr_accessor :hand

  def calc_value
    value = 0
    total = 0
    ace = false # ask about a better way...
    self.hand.each do |card|
      if card.rank == 'j' || card.rank == 'q' || card.rank == 'k'
        value = 10
      elsif card.rank == 'a'
        value = 1
        ace = true
      else
        value = card.rank.to_i
      end
        total += value
    end
    # aces count as 11 when it would be beneficial for them to do so
    total += 10 if ace == true && total < 12
    total
  end

  def show_hand
    puts "#{self.hand} => #{calc_value} points"
  end

  def hit(deck)
    @hand << deck.deal
  end
end

class Player
  attr_accessor :hand, :name

  include Handable

  def initialize(name, hand=[])
    self.name = name
    self.hand = hand
  end

  def to_s
    hand.to_s
  end
end

class Dealer
  attr_accessor :hand

  include Handable

  def initialize(hand=[])
    self.hand = hand
  end

  def dealer_showing
    puts "Dealer is showing #{self.hand[0]}"
  end

end

####################################################################################
# Tests
####################################################################################

player = Player.new("tester")
dealer = Dealer.new
deck = Deck.new

puts "deal initial hand"
player.hit(deck)
player.hit(deck)

####################################################################################
# gameplay
####################################################################################

/
#initializing the game state
game_over = false
choice = nil

# i think this loop could be refactored to be more rubyist

# now for dealer

/

def game_over_text
  puts "you have"
  puts hand.to_s + " =>  #{player.calc_value} points"
  puts "dealer had"
  puts dealer_hand.to_s + " => #{dealer.calc_value} points"
end

def final_message
  if win?(hand, dealer_hand)
    puts "you win!"
  else
    puts "you lose..."
  end
end

class Blackjack
  attr_accessor :player, :dealer, :deck

  def initialize
    puts "Enter your name: "
    @player_name = gets.chomp
    @player_name = 'Playername' if @player_name == ""
    @player = Player.new(@player_name) #Could add a prompt that asks for your name and sets it to that name
    @dealer = Dealer.new
    @deck = Deck.new
  end


  def run
    deal_cards
    player_turn
    dealer_turn
    who_won?
  end

  def deal_cards
    puts "dealing two cards to player and dealer"
    puts ""
    self.player.hit(deck)
    self.dealer.hit(deck)
    self.player.hit(deck)
    self.dealer.hit(deck)
    puts "#{self.player.name} has"
    self.player.show_hand
    puts ""
    self.dealer.dealer_showing
    puts ""
  end

  def player_turn
    puts "Player takes their turn"
    puts ""
    choice = nil
    until choice == 2 || player.calc_value > 20
      self.player.show_hand
      puts "you can choose to \n1) hit\n2) stay"
      choice = gets.chomp.to_i
      if choice == 1
        self.player.hit(deck)
      end
    end

    if player.calc_value == 21
      puts "Congratulations! You hit blackjack! You win!"
      exit
    elsif player.calc_value > 21
      player.show_hand
      puts "Sorry, you bust. You lose..."
      exit
    end
  end

  def dealer_turn
    puts "Now dealer takes his turn"
    puts ""
    until dealer.calc_value > 16
      puts "Dealer has"
      dealer.show_hand
      puts ""
      puts "Dealer hits"
      dealer.hit(deck)
    end

    if dealer.calc_value > 21
      dealer.show_hand
      puts "Dealer busts..."
      puts "#{player.name} wins!"
      exit
    elsif dealer.calc_value == 21
      dealer.show_hand
      puts "Dealer hits blackjack..."
      puts ""
      puts "You lose #{player.name}..."
      exit
    end
  end

  def who_won?
    puts 'Dealer has'
    dealer.show_hand
    puts ""
    puts 'Player has'
    player.show_hand
    puts ""

    if player.calc_value > dealer.calc_value
      puts "#{player.name} has the higher score."
      puts "#{player.name} wins!"
      exit
    elsif player.calc_value <= dealer.calc_value
      puts "Dealer has the higher score."
      puts "Dealer wins!"
      exit
    else
      puts "something weird happened. Tell the developer to debug this!"
      exit
    end
  end

end

Blackjack.new.run

# tasks; 1) add edge case of blackjack initial hand
#
# It could be argued that based on the model we were shown we determined who won in the wrong way by
# doing it at the end. We could instate have the player winning be a matter of 1) not losing and 2) dealer losing
# and only compare hands at the end if no one has bust. If someone busts we go directly to the end to determine who won
# with the knowledge (player_bust == true say) of who has bust
