require_relative './board'
require_relative './player'
require_relative './computer'

class Game
  attr_accessor :game_board, :player_human, :player_computer, :cur_move, :moves_until_checkmate

  def initialize
    @game_board = Board.new
    @player_human = Player.new
    @player_computer = Computer.new
    # 0 is white 1 is black
    @cur_move = 0
  end

  def play
    puts 'You will be playing a game of chess against a computer that makes random moves!'

    inp_color = prompt_color
    @player_human.color = inp_color == '0' ? 'white' : 'black'
    @player_computer.color = inp_color == '0' ? 'black' : 'white'

    start_moves
  end

  # Ask player for desired color
  def prompt_color
    puts "\nEnter 0 if you want to be white or 1 for black"
    loop do
      inp = gets.chomp
      return inp if %w[0 1].include?(inp)

      puts 'Invalid input, try again'
    end
  end

  # Alternate between player and computer moves
  def start_moves
    loop do
      game_board.display
      if cur_move.zero?
        player_human.color == 'white' ? @player_human.make_move(game_board) : @player_computer.make_move(game_board)
      else
        player_human.color == 'white' ? @player_computer.make_move(game_board) : @player_human.make_move(game_board)
      end
      @moves_until_checkmate += 1

      # End game if checkmate
      cur_turn = cur_move.even? ? 'white' : 'black'
      if game_board.check_mate?(cur_turn)
        puts cur_turn == player_human.color ? "Congrats! You won against the computer in #{moves_until_checkmate} moves!" : "LMAOOOO you're terrible at chess you lost against a bot"
        exit
      end

      @cur_move = (cur_move + 1) % 2
    end
  end
end
