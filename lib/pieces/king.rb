require_relative '../../lib/board'

class King
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[0,1], [1,1], [1,0], [0,-1], [-1,-1], [-1,0], [-1,1], [1,-1]]
    @position = position
    @icon = is_white ? "@".white : "@".black
    @is_white = is_white
    @potential_moves = nil
  end

  def in_moveset?(move, board_state)

    #TODO check for check & checkmate before allowing move
    # each time a piece moves, iterate to make an array of all possible moves
    # check if any of them is_a?(King) and probably check color
    # no need to build list until pieces start moving
  end
end
