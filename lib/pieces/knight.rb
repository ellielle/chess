class Knight
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[1,2], [-1,2], [1,-2], [-1,-2], [2,1], [-2,1], [2,-1], [-2,-1]]
    @position = position
    @icon = is_white ? "K".white : "K".black
    @is_white = is_white
  end

  def in_moveset?(move)
    @moves.each do |moveset|
      if move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1]
        return true
      end
    end
  end
end
