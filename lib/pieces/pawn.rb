require "board"

class Pawn < Piece
  attr_accessor :moves, :position, :icon #TODO

  def initialize(position, is_first)
    @moves = {
        regular: [0,1],
        two_steps: [0,2],
        en_passant: [1,1]
    }
    @position = position
    @icon = is_first ? "♙" : "♟"
    @first_move = true
    #TODO en passant & promotion
  end
  
end