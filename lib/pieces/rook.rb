require_relative '../../lib/board'
require_relative '../../lib/convert'
require_relative '../../lib/piece_methods'

class Rook
  include ConvertCoordinates, PieceMethods

  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = create_moveset
    @position = position
    @icon = is_white ? "R".white : "R".black
    @is_white = is_white
    @potential_moves = nil
  end

  def in_moveset?(move, board_state)
    @moves.each do |moveset|
      if move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1] &&
          path_clear?(move, board_state)
        return true
      end
    end
    false
  end

  def path_clear?(move, board_state)
    horizontal_path_clear?(move, board_state)
  end

  def create_moveset
    moves = []
    1.upto(7) { |num| moves << [0, num] }
    1.upto(7) { |num| moves << [num, 0] }
    -1.downto(-7) { |num| moves << [0, num] }
    -1.downto(-7) { |num| moves << [num, 0] }
    moves
  end

  def find_potential_moves(board_state)
    @potential_moves = potential_moves(@moves, @position, @is_white, board_state)
  end
end
