require_relative '../../lib/pieces/piece'

class King < Piece
  attr_accessor :moves, :position, :icon

  def initialize(position, is_first)
    @moves = []
    @position = position
    @icon = is_first ? "K".white : "K".black
  end

end