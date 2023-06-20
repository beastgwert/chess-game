class King
  attr_accessor :position, :symbol, :next_moves, :color

  def initialize(start_position, symbol, color)
    @position = start_position
    @symbol = symbol
    @color = color
    @next_moves = []
  end

  def valid_move?(board, row, col)
    return false if row.negative? || row > 7 || col.negative? || col > 7
    return true if board.positions[row][col] == '.'
    return false if board.positions[row][col].color == @color

    true
  end
end

class WhiteKing < King
  def initialize(row, col)
    super([row, col], '♔', 'white')
  end
end

class BlackKing < King
  def initialize(row, col)
    super([row, col], '♚', 'black')
  end
end