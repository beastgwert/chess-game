class Pawn
  attr_accessor :position, :symbol, :next_moves, :color

  def initialize(start_position, symbol, color)
    @position = start_position
    @symbol = symbol
    @color = color
    @next_moves = []
  end

  def empty_square?(board, row, col)
    return false if row > 7 || col.negative? || row > 7 || col.negative?

    board.positions[row][col] == '.'
  end

  def opponent_piece?(board, row, col)
    return false if row > 7 || col.negative? || row > 7 || col.negative? || board.positions[row][col] == '.'

    @color != board.positions[row][col].color
  end

  def promote?
    row = @position[0]
    [0, 7].include?(row)
  end
  
  def valid_move?(board, row, col)
    return false if row.negative? || row > 7 || col.negative? || col > 7
    return true if board.positions[row][col] == '.'
    return false if board.positions[row][col].color == @color

    true
  end
end

class WhitePawn < Pawn
  def initialize(row, col)
    super([row, col], '♙', 'white')
  end

  def update_next_moves(board)
    @next_moves.clear
    row = position[0]
    col = position[1]

    # Move two ahead when pawn has not moved
    if row == 1 && empty_square?(board, row + 1, col) && empty_square?(board, row + 2, col)
      @next_moves.push([row + 2, col])
    end

    # Move one ahead
    @next_moves.push([row + 1, col]) if empty_square?(board, row + 1, col)

    # Move top left diagonal
    @next_moves.push([row + 1, col - 1]) if opponent_piece?(board, row + 1, col - 1)

    # Move top right diagonal
    @next_moves.push([row + 1, col + 1]) if opponent_piece?(board, row + 1, col + 1)
  end
end

class BlackPawn < Pawn
  def initialize(row, col)
    super([row, col], '♟︎', 'black')
  end

  def update_next_moves(board)
    @next_moves.clear
    row = position[0]
    col = position[1]

    # Move two below when pawn has not moved
    if row == 6 && empty_square?(board, row - 1, col) && empty_square?(board, row - 2, col)
      @next_moves.push([row - 2, col])
    end

    # Move one ahead
    @next_moves.push([row - 1, col]) if empty_square?(board, row - 1, col)

    # Move top left diagonal
    @next_moves.push([row - 1, col - 1]) if opponent_piece?(board, row - 1, col - 1)

    # Move top right diagonal
    @next_moves.push([row - 1, col + 1]) if opponent_piece?(board, row - 1, col + 1)
  end
end