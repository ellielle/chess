class Rook
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = []
    @position = position
    @icon = is_white ? "R".white : "R".black
    @is_white = is_white
  end
end
