require './lib/board'

class Player
  attr_accessor :color

  # Actual notation for ranks and files
  RANK = %w[1 2 3 4 5 6 7 8].freeze
  FILE = ('a'..'h').to_a.concat(('A'..'H').to_a).freeze

  def initialize
    @color = ''
  end

  def make_move(board)
    loop do
      # Obtain starting and ending squares
      initial_position = select_position(board)
      new_position = find_new_position(board, initial_position)
      new_piece = board.positions[new_position[0]][new_position[1]]

      # Move the piece and update the board
      initial_piece = board.positions[initial_position[0]][initial_position[1]]
      initial_piece.update_position(board, new_position, initial_position)
      board.update_all_pieces_next_moves

      # Make sure legal move if king is in check
      king_position = @color == 'white' ? board.king_positions[:white] : board.king_positions[:black]
      player_king = board.positions[king_position[0]][king_position[1]]
      return unless player_king.in_check?(board)
      
      # Reset to old position if invalid move
      initial_piece.update_position(board, initial_position, new_position)
      board.positions[new_position[0]][new_position[1]] = new_piece
      board.update_all_pieces_next_moves

      puts "That is an invalid move because you are in check, please try again \n"
    end
  end

  # Ask for piece to move
  def select_position(board)
    loop do
      puts 'Choose a square that a piece occupies to move (i.e E2)'
      input = gets.chomp

      return notation_to_position(input) if verify_select(board, input)

      puts "That is an invalid square, please try again\n"
    end
  end

  # Check that selected piece to move is valid
  def verify_select(board, input)
    return false unless input.length == 2
    return false if !FILE.include?(input[0]) || !RANK.include?(input[1])

    pos = notation_to_position(input)
    piece = board.positions[pos[0]][pos[1]]
    return false if piece == '.' || piece.color != @color || piece.next_moves == []

    true
  end

  # Ask for square to move to 
  def find_new_position(board, initial_position)
    loop do
      puts 'Choose a square to move to'
      input = gets.chomp

      return notation_to_position(input) if verify_find(board, input, initial_position)

      puts "That is an invalid square, please try again\n"
    end
  end

  # Check that square to move to is valid
  def verify_find(board, input, initial_position)
    return false unless input.length == 2
    return false if !FILE.include?(input[0]) || !RANK.include?(input[1])

    pos = notation_to_position(input)
    piece = board.positions[pos[0]][pos[1]]
    return false if piece != '.' && piece.color == @color

    return false unless board.positions[initial_position[0]][initial_position[1]].next_moves.include?(pos)

    true
  end

  # Converts chess notation to 2-element array
  def notation_to_position(notation)
    file = notation[0]
    rank = notation[1]
    [rank.to_i - 1, file.downcase.ord - 97]
  end
end
