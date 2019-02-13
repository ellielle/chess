require "board"

class Pawn < Piece
  def initialize(position, is_first)
    @moves = {} #TODO moveset
    @position = position
    @icon = is_first ? "♙" : "♟"
    @first_move = true
    #TODO en passant & promotion
  end


end