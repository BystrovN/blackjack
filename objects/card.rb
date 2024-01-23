require_relative '../config'

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    Config::RANK_VALUES[rank]
  end

  def inspect
    "#{rank} - #{suit}"
  end
end
