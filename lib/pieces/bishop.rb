require_relative '../../lib/board'
require_relative '../../lib/convert'
require_relative '../../lib/piece_methods'

class Bishop
  include ConvertCoordinates, PieceMethods

  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = [[1..7, 1..7], [-7..-1, -7..-1], [1..7, -7..-1], [-7..-1, 1..7]]
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
    #TODO change moveset like rook.rb

    #TODO make sure diagonal moves are the same number or invalid move
    #TODO ensure no pieces are in path except potentially at the finish pos
  end

  def find_potential_moves(board_state)
    @potential_moves = potential_moves(@moves, @position, @is_white, board_state)
  end
end
