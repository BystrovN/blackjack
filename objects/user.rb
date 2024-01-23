require_relative '../config'

class User
  attr_reader :cards, :death_balance, :name
  attr_accessor :balance

  def initialize(name)
    @name = name
    @balance = Config::START_BALANCE
    @cards = []
    @death_balance = Config::DEATH_BALANCE
  end

  def take_card(card)
    cards << card unless full_hand?
  end

  def sum_card
    points = 0
    aces_count = 0
    cards.each do |card|
      if card.rank == 'A'
        aces_count += 1
        next
      end

      points += card.value
    end

    points += aces_sum(aces_count, points)
  end

  def clear_hand
    used_cards = cards.dup
    cards.clear
    used_cards
  end

  def possible_to_play?
    balance > death_balance
  end

  def full_hand?
    cards.length >= 3
  end

  protected

  attr_writer :cards

  def aces_sum(aces_count, exist_points)
    return 0 if aces_count.zero?

    max_sum = 11 + (1 * (aces_count - 1))
    min_sum = 1 * aces_count
    max_sum + exist_points <= 21 ? max_sum : min_sum
  end
end
