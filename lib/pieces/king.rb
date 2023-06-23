class King
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
    old_row = old_position[0]
    old_col = old_position[1]
    new_row = new_position[0]
    new_col = new_position[1]

    board.positions[new_row][new_col] = self
    board.positions[old_row][old_col] = '.'

    # Queenside castle
    if new_col - old_col == -2
      board.positions[new_row][new_col + 1] = board.positions[new_row][0]
      board.positions[new_row][0] = '.'
    end

    # Kingside castle
    if new_col - old_col == 2
      board.positions[new_row][new_col - 1] = board.positions[new_row][7]
      board.positions[new_row][7] = '.'
    end

    @has_moved = true
  end

  def update_next_moves(board)
    @next_moves.clear

    row = position[0]
    col = position[1]

    # 8 basic directions
    @next_moves.push([row + 1, col]) if valid_move?(board, row + 1, col)
    @next_moves.push([row - 1, col]) if valid_move?(board, row - 1, col)
    @next_moves.push([row, col + 1]) if valid_move?(board, row, col + 1)
    @next_moves.push([row, col - 1]) if valid_move?(board, row, col - 1)
    @next_moves.push([row + 1, col + 1]) if valid_move?(board, row + 1, col + 1)
    @next_moves.push([row + 1, col - 1]) if valid_move?(board, row + 1, col - 1)
    @next_moves.push([row - 1, col + 1]) if valid_move?(board, row - 1, col + 1)
    @next_moves.push([row - 1, col - 1]) if valid_move?(board, row - 1, col - 1)

    # Castling
    @next_moves.push([row, col - 2]) if left_castling_possible?(board)
    @next_moves.push([row, col + 2]) if right_castling_possible?(board)

    @next_moves -= attacked_squares(board)
  end

  def valid_move?(board, row, col)
    return false if row.negative? || row > 7 || col.negative? || col > 7
    return true if board.positions[row][col] == '.'
    return false if board.positions[row][col].color == @color

    true
  end

  def in_check?(board)
    attacked_squares(board).include?(@position)
  end

  def attacked_squares(board)
    attacked = []
    board.positions.each do |row|
      row.each do |piece|
        next if piece == '.' || piece.color == @color

        attacked += piece.next_moves unless piece.is_a?(Pawn)
        # Pawn's diagonal attack
        if piece.instance_of?(WhitePawn)
          row2 = piece.position[0]
          col2 = piece.position[1]
          attacked += [[row2 + 1, col2 - 1], [row2 + 1, col2 + 1]]
        end
        next unless piece.instance_of?(BlackPawn)

        row2 = piece.position[0]
        col2 = piece.position[1]
        attacked += [[row2 - 1, col2 - 1], [row2 - 1, col2 + 1]]
      end
    end
    attacked.uniq
  end
end

class WhiteKing < King
  def initialize(row, col)
    super([row, col], '♔', 'white')
  end

  def left_castling_possible?(board)
    if has_moved || board.positions[0][0] == '.' || !board.positions[0][0].is_a?(Rook) || board.positions[0][0].has_moved
      return false
    end

    # Check that nothing is between the king and rook
    (1..3).each do |i|
      return false unless board.positions[0][i] == '.'
    end

    # Check that nothing is attacking a square between the king and rook
    return false if (attacked_squares(board) & [[0, 2], [0, 3]]).any?

    true
  end

  def right_castling_possible?(board)
    if has_moved || board.positions[0][7] == '.' || !board.positions[0][7].is_a?(Rook) || board.positions[0][7].has_moved
      return false
    end

    # Check that nothing is between the king and rook
    (5..6).each do |i|
      return false unless board.positions[0][i] == '.'
    end

    # Check that nothing is attacking a square between the king and rook
    return false if (attacked_squares(board) & [[0, 5], [0, 6]]).any?

    true
  end
end

class BlackKing < King
  def initialize(row, col)
    super([row, col], '♚', 'black')
  end

  def left_castling_possible?(board)
    if has_moved || board.positions[7][0] == '.' || !board.positions[7][0].is_a?(Rook) || board.positions[7][0].has_moved
      return false
    end

    # Check that nothing is between the king and rook
    (1..3).each do |i|
      return false unless board.positions[7][i] == '.'
    end

    # Check that nothing is attacking a square between the king and rook
    return false if (attacked_squares(board) & [[7, 2], [7, 3]]).any?

    true
  end

  def right_castling_possible?(board)
    if has_moved || board.positions[7][7] == '.' || !board.positions[7][7].is_a?(Rook) || board.positions[7][7].has_moved
      return false
    end

    # Check that nothing is between the king and rook
    (5..6).each do |i|
      return false unless board.positions[7][i] == '.'
    end

    # Check that nothing is attacking a square between the king and rook
    return false if (attacked_squares(board) & [[7, 5], [7, 6]]).any?

    true
  end
end
