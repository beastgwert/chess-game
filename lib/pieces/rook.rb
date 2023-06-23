class Rook
  attr_accessor :position, :symbol, :next_moves, :color, :has_moved

  def initialize(start_position, symbol, color)
    @position = start_position
    @symbol = symbol
    @color = color
    @next_moves = []
    @has_moved = false
  end

  def update_position(board, new_position, old_position)
    @position = new_position
    board.positions[new_position[0]][new_position[1]] = self
    board.positions[old_position[0]][old_position[1]] = '.'
  end

  def update_next_moves(board)
    @next_moves.clear

    # up
    row = position[0] + 1
    col = position[1]
    while valid_move?(board, row, col)
      @next_moves.push([row, col])
      break unless board.positions[row][col] == '.'

      row += 1
    end

    # right
    row = position[0]
    col = position[1] + 1
    while valid_move?(board, row, col)
      @next_moves.push([row, col])
      break unless board.positions[row][col] == '.'

      col += 1
    end

    # down
    row = position[0] - 1
    col = position[1]
    while valid_move?(board, row, col)
      @next_moves.push([row, col])
      break unless board.positions[row][col] == '.'

      row -= 1
    end

    # left
    row = position[0]
    col = position[1] - 1
    while valid_move?(board, row, col)
      @next_moves.push([row, col])
      break unless board.positions[row][col] == '.'

      col -= 1
    end
  end

  def valid_move?(board, row, col)
    return false if row.negative? || row > 7 || col.negative? || col > 7
    return true if board.positions[row][col] == '.'
    return false if board.positions[row][col].color == @color

    true
  end
end

class WhiteRook < Rook
  def initialize(row, col)
    super([row, col], '♖', 'white')
  end
end

class BlackRook < Rook
  def initialize(row, col)
    super([row, col], '♜', 'black')
  end
end
