require_relative './board'
require_relative './player'
require_relative './computer'

class Game
  attr_accessor :game_board, :player_human, :player_computer, :cur_move

  def initialize
    @game_board = Board.new
    @player_human = Player.new
    @player_computer = Computer.new
    # 0 is white 1 is black
    @cur_move = 0
  end

  def play
    puts "You will be playing a game of chess against a computer that makes random moves!"
    puts "\nYou can save the game at any time by entering \"save_game\" into the terminal"

    inp_color = prompt_color
    @player_human.color = inp_color.to_i
    @player_computer.color = 1 - player_human.color.to_i

    start_moves
  end

  def prompt_color
    puts "\nEnter 0 if you want to be white or 1 for black"
    loop do
      inp = gets.chomp
      return inp if ["0", "1"].include?(inp)
      puts "Invalid input, try again"
    end
	end

  def start_moves
    #loop do
			game_board.display
      if cur_move == 0
        player_human.color.zero? ? @player_human.make_move : @player_computer.make_move
      else
        player_human.color.zero? ? @player_computer.make_move : @player_human.make_move
      end
      @cur_move = (cur_move + 1) % 2
    #end
  end
end