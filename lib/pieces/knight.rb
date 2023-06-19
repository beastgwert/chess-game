class Knight
  attr_accessor :position, :symbol, :next_moves, :color

  def initialize(start_position, symbol, color)
    @position = start_position
    @symbol = symbol
    @color = color
    @next_moves = []
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