require "board"

class Knight < Piece
  def initialize(position, is_first)
    @moves = [
        [1,2],
        [-1,2],
        [1,-2],
        [-1,-2],
        [2,1],
        [-2,1],
        [2,-1],
        [-2,-1]
    ]
    @position = position
    @icon = is_first ? "♘" : "♞"
  end
end