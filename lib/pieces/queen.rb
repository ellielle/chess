class Queen
  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[0, 1..7], [1..7, 0], [1..7, 1..7], [-7..-1, -7..-1], [1..7, -7..-1], [-7..-1, 1..7]]
    @position = position
    @icon = is_white ? "Q".white : "Q".black
    @is_white = is_white
    @potential_moves = nil
  end

  def in_moveset?(move, board_state)
    #TODO change moveset like rook.rb

    #TODO make sure diagonal moves are the same number or invalid move
    #TODO ensure no pieces are in path except potentially at the finish pos
  end
end
