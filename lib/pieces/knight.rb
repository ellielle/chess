class Knight
  attr_accessor :moves, :position, :icon

  def initialize(position, is_first)
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
    @icon = is_first ? "K".white : "K".black
  end
end
