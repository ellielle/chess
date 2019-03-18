class Queen
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[0, 1..7], [1..7, 0], [1..7, 1..7], [-7..-1, -7..-1], [1..7, -7..-1], [-7..-1, 1..7]]
    @position = position
    @icon = is_white ? "Q".white : "Q".black
    @is_white = is_white
  end

  def in_moveset?(move)
    #TODO make sure diagonal moves are the same number or invalid move
  end
end
