require_relative 'card'

class Deck
  RANKS = Config::RANK_VALUES.keys
  SUITS = %w[♥ ♦ ♠ ♣].freeze

  attr_reader :cards

  def initialize
    @cards = fill_deck
  end

  def fill_deck
    RANKS.product(SUITS).map { |rank, suit| Card.new(rank, suit) }
  end

  def pick_up_card
    cards.pop
  end

  def shuffle!
    cards.shuffle!
  end

  def return_cards_to_deck(*used_cards)
    used_cards.each { |card| cards << card if card.is_a?(Card) && !cards.include?(card) }
  end

  protected

  attr_writer :cards
end
