class Knight
  attr_accessor :position, :symbol, :next_moves, :color

  def initialize(start_position, symbol, color)
    @position = start_position
    @symbol = symbol
    @color = color
    @next_moves = []
  end

  def update_next_moves(board)
    @next_moves.clear
    
    row = position[0]
    col = position[1]

    @next_moves.push([row + 2, col + 1]) if valid_move?(board, row + 2, col + 1)
    @next_moves.push([row + 1, col + 2]) if valid_move?(board, row + 1, col + 2)
    @next_moves.push([row - 1, col + 2]) if valid_move?(board, row - 1, col + 2)
    @next_moves.push([row - 2, col + 1]) if valid_move?(board, row - 2, col + 1)
    @next_moves.push([row - 2, col - 1]) if valid_move?(board, row - 2, col - 1)
    @next_moves.push([row - 1, col - 2]) if valid_move?(board, row - 1, col - 2)
    @next_moves.push([row + 1, col - 2]) if valid_move?(board, row + 1, col - 2)
    @next_moves.push([row + 2, col - 1]) if valid_move?(board, row + 2, col - 1)
  end
  
  def valid_move?(board, row, col)
    return false if row.negative? || row > 7 || col.negative? || col > 7
    return true if board.positions[row][col] == '.'
    return false if board.positions[row][col].color == @color

    true
  end
end

class WhiteKnight < Knight
  def initialize(row, col)
    super([row, col], '♘', 'white')
  end
end

class BlackKnight < Knight
  def initialize(row, col)
    super([row, col], '♞', 'black')
  end
end