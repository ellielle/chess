class King
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[0,1], [1,1], [1,0], [0,-1], [-1,-1], [-1,0], [-1,1], [1,-1]]
    @position = position
    @icon = is_white ? "@".white : "@".black
    @is_white = is_white
  end

end
