require_relative '../../lib/board'
require_relative '../../lib/convert'
require_relative '../../lib/piece_methods'

class Knight
  include ConvertCoordinates, PieceMethods

  attr_accessor :position
  attr_reader :moves, :icon, :is_white, :potential_moves

  def initialize(position, is_white)
    @moves = [[1,2], [-1,2], [1,-2], [-1,-2], [2,1], [-2,1], [2,-1], [-2,-1]]
    @position = position
    @icon = is_white ? "K".white : "K".black
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
    move_to_sym = convert_number_to_position(move[1]).to_sym
    if @is_white
      return true if board_state[move_to_sym].nil? || !board_state[move_to_sym].is_white
    else
      return true if board_state[move_to_sym].nil? || board_state[move_to_sym].is_white
    end
    false
  end

  def find_potential_moves(board_state)
    @potential_moves = potential_move_list(@moves, @position, @is_white, board_state)
  end
end
