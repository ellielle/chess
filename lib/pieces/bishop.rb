require_relative '../../lib/board'
require_relative '../../lib/convert'
require_relative '../../lib/piece_methods'

class Bishop
  include ConvertCoordinates, PieceMethods

  attr_accessor :position
  attr_reader :moves, :icon, :is_white, :potential_moves

  def initialize(position, is_white)
    @moves = create_moveset
    @position = position
    @icon = is_white ? "B".white : "B".black
    @is_white = is_white
    @potential_moves = nil
  end

  def create_moveset
    moves = []
    1.upto(7) { |num| moves << [num, num] }
    1.upto(7) { |num| moves << [num, -(num.abs)] }
    1.upto(7) { |num| moves << [-(num.abs), num] }
    -1.downto(-7) { |num| moves << [num, num] }
    moves
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
    diagonal_path_clear?(move, board_state)
  end

  def find_potential_moves(board_state)
    @potential_moves = potential_move_list(@moves, @position, @is_white, board_state)
  end
end
