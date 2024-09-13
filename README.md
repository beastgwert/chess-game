# chess-game
Interactive chess game against a computer that makes random moves from the command line written in Ruby.


## How to Play
- Clone this repo ([instructions](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository))
- Navigate to the project's directory `cd chess-game`
- `bundle install`
- `ruby lib/main.rb`

## Rules
Maintains the rules of chess and individual pieces in various contexts, including:

- Special moves
    - Promotions
        - A piece can turn into any other piece once it reaches the final rank
    - Castling
        - Kingside and Queenside castling
        - King has not moved
        - King or a square along the path to its destination square is not in check
    - En-passant
        - Only possible if opponent's pawn has moved two squares in one move
- Valid Squares
    - A piece cannot move if the King is in check following the move
    - A move must be to a square within the capabilities of the piece
- Checkmate if the player cannot move and is in check

Player can resign by entering the command in the console






