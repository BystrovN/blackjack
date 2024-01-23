require_relative 'objects/user'
require_relative 'objects/deck'
require_relative 'config'

class BlackJack
  DEPOSIT = Config::BANK_DEPOSIT
  DEALER_SUM_CARD_LIMIT = 17

  attr_reader :player, :dealer, :deck
  attr_accessor :bank

  def initialize(player_name)
    @player = User.new(player_name)
    @dealer = User.new('Дилер')
    @deck = Deck.new
    @bank = 0
  end

  def start_game
    loop do
      reset_game
      bank_deposit
      deal_initial_cards
      display_players_cards
      turns
      display_result
      break unless play_again?
    end
  end

  def reset_game
    self.bank = 0
    deck.return_cards_to_deck(*player.clear_hand, *dealer.clear_hand)
    deck.shuffle!
  end

  def bank_deposit
    self.bank += DEPOSIT * 2
    player.balance -= DEPOSIT
    dealer.balance -= DEPOSIT
  end

  def deal_initial_cards
    2.times do
      player.take_card(deck.pick_up_card)
      dealer.take_card(deck.pick_up_card)
    end
  end

  def display_players_cards(dealer_show: false)
    puts "Рука игрока #{player.name}: #{player.cards}"
    puts dealer_show ? "Рука дилера: #{dealer.cards}" : "Рука дилера: #{'*' * dealer.cards.length}"
  end

  def player_turn
    puts 'Выбирите действие:'
    puts ['1 - Пропустить', '2 - Добавить карту', '3 - Открыть карты']
    choice = gets.chomp!.to_i

    case choice
    when 1
      puts 'Ход пропущен'
      choice
    when 2
      puts 'Больше взять карт нельзя' if player.take_card(deck.pick_up_card).nil?
      choice
    when 3
      puts 'Открываем карты'
      choice
    else
      puts 'Неверный выбор, попробуйте еще раз.'
      player_turn
    end
  end

  def dealer_turn
    dealer.take_card(deck.pick_up_card) if dealer.sum_card < DEALER_SUM_CARD_LIMIT
  end

  def display_result
    display_players_cards(dealer_show: true)

    puts "Сумма карт игрока - #{player_score = player.sum_card}"
    puts "Сумма карт дилера - #{dealer_score = dealer.sum_card}"

    if player_score > 21 || (dealer_score <= 21 && dealer_score > player_score)
      puts 'Дилер выиграл'
      dealer.balance += bank
    elsif dealer_score > 21 || (player_score <= 21 && player_score > dealer_score)
      puts 'Вы выиграли'
      player.balance += bank
    else
      puts 'Ничья'
      player.balance += DEPOSIT
      dealer.balance += DEPOSIT
    end

    puts "Баланс игрока: $#{player.balance}, Баланс дилера: $#{dealer.balance}"
  end

  def play_again?
    puts 'Желаете сыграть еще?'
    puts ['1 - Да', '2 - Нет']
    choice = gets.chomp!.to_i

    case choice
    when 1
      return true if player.possible_to_play?

      puts 'Продолжать игру невозможно. Вы уже все проиграли.'
      false
    when 2
      false
    else
      puts 'Неверный выбор, попробуйте еще раз.'
      play_again?
    end
  end

  def turns
    return if player.full_hand? && (dealer.full_hand? || dealer.sum_card >= DEALER_SUM_CARD_LIMIT)

    player_choice = player_turn
    case player_choice
    when 3
      nil
    else
      dealer_turn
      turns
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  print 'Ваше имя? - '
  name = gets.chomp!
  BlackJack.new(name).start_game
end
