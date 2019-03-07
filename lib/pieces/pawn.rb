class Pawn
  attr_accessor :moves, :position, :icon #TODO

  def initialize(position, is_first)
    @moves = is_first ? white_moves : black_moves
    @position = position
    @icon = is_first ? "P".white : "P".black
    @first_move = true
    #TODO en passant & promotion
    #TODO set first_move to false after move
  end

  def white_moves
    hsh = {}
  end

  def black_moves
    hsh = {}
  end

end
