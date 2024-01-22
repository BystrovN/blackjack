require_relative '../config'

class User
  attr_accessor :balance

  def initialize(name)
    @name = name # запросим
    @balance = Config::START_BALANCE
    @cards = [] # При инициализации пустой массив
    @death_balance = Config::DEATH_BALANCE # Думаю стоит прописать параметр баланса, ниже которого продолжение игры невозможно
  end

  # В класс добавить методы:
  #   - добавить карту в руку (если в руке меньше трех карт)
  #   - показать карты на руке
  #   - показать сумму карт на руке (в нем же учесть особенность веса туза)
  #   - сбросить карты с руки
  #   - проверка не опустился ли пользователь до баланса, ниже которого продолжение игры невозможно. Возможно это будет метод valid?
  #   - проверка не полная ли у пользователя рука (false если в руке меньше трех карт)
  #   - хз может еще что-то
end

# Для инстанса игрока и дилера предполагаю использовать один класс User, просто дилеру дать соответствующее имя.