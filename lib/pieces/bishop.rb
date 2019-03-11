class Bishop
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = []
    @position = position
    @icon = is_white ? "B".white : "B".black
    @is_white = is_white
  end
end
