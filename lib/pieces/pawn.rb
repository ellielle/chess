class Pawn
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = is_white ? white_moves : black_moves
    @position = position
    @icon = is_white ? "P".white : "P".black
    @is_white = is_white
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
