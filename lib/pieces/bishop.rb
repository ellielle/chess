require_relative '../../lib/pieces/piece'

class Bishop < Piece
  attr_accessor :moves, :position, :icon

  def initialize(position, is_first)
    @moves = []
    @position = position
    @icon = is_first ? "B".white : "B".black
  end
end