require "./pieces/piece"

class Rook < Piece
  attr_accessor :moves, :position, :icon

  def initialize(position, is_first)
    @moves = []
    @position = position
    @icon = is_first ? "♖" : "♜"
  end
end