require_relative 'card'

class Deck
  attr_reader :cards

  def initialize
    @cards = [] # Массив объектов класса Card. Заполняются при создании инстанса
  end

  # В класс добавить методы:
  #   - заполнить колоду
  #   - выдать карту из верха колоды
  #   - перемешать колоду
  #   - хз может еще что-то
end
