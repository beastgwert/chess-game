
class Computer
    attr_accessor :color

    def initialize
        @color = 1
    end

    def make_move(board)
        availible_pieces = []

        board.positions.each do |row|
            row.each do |piece|
                availible_pieces.push(piece.position) unless piece == '.' || piece.color != @color || piece.next_moves == []
            end
        end
        
        loop do
            initial_position = availible_pieces.sample
            initial_piece = board.positions[initial_position[0]][initial_position[1]]
            new_position = initial_piece.next_moves.sample
            new_piece = board.positions[new_position[0]][new_position[1]]

            initial_piece.update_position(board, new_position, initial_position)
            board.update_all_pieces_next_moves

            @color == 'white' ? king_position = board.king_positions[:white] : king_position = board.king_positions[:black]
            player_king = board.positions[king_position[0]][king_position[1]]
            if player_king.in_check?(board)
                initial_piece.update_position(board, initial_position, new_position)
                board.positions[new_position[0]][new_position[1]] = new_piece
                board.update_all_pieces_next_moves
            else
                return
            end
        end
    end
end