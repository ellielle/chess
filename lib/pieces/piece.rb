require "board"

class Piece
  def initialize(position, is_first)
    @position = position
    @color = is_first ? "white" : "black"
  end

  def get_possible_moves; end

end