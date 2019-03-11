class Knight
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [
        [1,2],
        [-1,2],
        [1,-2],
        [-1,-2],
        [2,1],
        [-2,1],
        [2,-1],
        [-2,-1]
    ]
    @position = position
    @icon = is_white ? "K".white : "K".black
    @is_white = is_white
  end
end
