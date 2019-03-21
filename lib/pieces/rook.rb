require_relative '../../lib/board'
require_relative '../../lib/convert'

class Rook
  include ConvertCoordinates

  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = set_moveset
    @position = position
    @icon = is_white ? "R".white : "R".black
    @is_white = is_white
  end

  def in_moveset?(move, board_state)
    @moves.each do |moveset|
      if move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1] &&
          path_clear?(move, board_state)
        return true
      end
    end

    #TODO ensure no pieces are in path except potentially at the finish pos
    false
  end

  def path_clear?(move, board_state)
    if move[0][0] == move[1][0]
      if move[0][1] < move[1][1]
        start = move[0][1] + 1
        start.upto(move[1][1]) do |space|
          return false unless board_state[convert_number_to_position([move[0][0], space]).to_sym].nil?
        end
      elsif move[0][1] > move[1][1]
        start = move[0][1] - 1
        start.downto(move[1][1]) do |space|
          return false unless board_state[convert_number_to_position([move[0][0], space]).to_sym].nil?
        end
      end
    elsif move[0][1] == move[1][1]
      if move[0][0] < move[1][0]
        start = move[0][0] + 1
        start.upto(move[1][0]) do |space|
          return false unless board_state[convert_number_to_position([space, move[0][1]]).to_sym].nil?
        end
      elsif move[0][0] > move[1][0]
        start = move[0][0] - 1
        start.downto(move[1][0]) do |space|
          return false unless board_state[convert_number_to_position([space, move[0][1]]).to_sym].nil?
        end
      end
    end
  end

  def set_moveset
    moves = []
    1.upto(7) { |num| moves << [0, num] }
    1.upto(7) { |num| moves << [num, 0] }
    -1.downto(-7) { |num| moves << [0, num] }
    -1.downto(-7) { |num| moves << [num, 0] }
    moves
  end
end
