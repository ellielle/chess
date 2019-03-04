require_relative '../../lib/pieces/piece'

class Pawn < Piece
  attr_accessor :moves, :position, :icon #TODO

  def initialize(position, is_first)
    @moves = {
        #TODO make moves color based for pawns so they can only move 1 way
    }
    @position = position
    @icon = is_first ? "♙" : "♟"
    @first_move = true
    #TODO en passant & promotion
    #TODO set first_move to false after move
  end
  
end