class Bishop
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[1..7, 1..7], [-7..-1, -7..-1], [1..7, -7..-1], [-7..-1, 1..7]]
    @position = position
    @icon = is_white ? "B".white : "B".black
    @is_white = is_white
  end

  #TODO make sure diagonal moves are the same number or invalid move
end
