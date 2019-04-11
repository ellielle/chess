require_relative '../../lib/board'
require_relative '../../lib/convert'
require_relative '../../lib/piece_methods'

class Pawn
  include ConvertCoordinates, PieceMethods

  attr_accessor :position
  attr_reader :moves, :icon, :is_white, :potential_moves, :can_be_en_passant

  def initialize(position, is_white)
    @moves = is_white ? white_moves : black_moves
    @position = position
    @icon = is_white ? "P".white : "P".black
    @is_white = is_white
    @can_be_en_passant = false
    @first_move = true
    @potential_moves = nil
    #TODO en passant & promotion
    #TODO set first_move to false after move
  end

  def white_moves
    moves = [[0, 1], [0, 2], [1, 1], [-1, 1]]
  end

  def black_moves
    moves = [[0, -1], [0, -2], [-1, -1], [1, -1]]
  end
#TODO unset enpassant on next move if it's set to true
  def in_moveset?(move, board_state)
    finish = convert_number_to_position(move[1])
    return false if move[1][0] < 1 || move[1][0] > 8 || move[1][1] < 0 || move[1][1] > 8
    if @is_white
      @moves.each do |moveset|
        if move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1]
          if moveset == [0, 1]
            return true if board_state[finish.to_sym].nil?
          elsif moveset == [0, 2]
            return false unless @first_move
            @can_be_en_passant = true
            return true
          elsif moveset == [1, 1] || moveset == [-1, 1]
            unless board_state[finish.to_sym].nil? || board_state[finish.to_sym].is_white
              return true
            end
          end
        end
      end
      @first_move = false if @first_move
      @can_be_en_passant = false if @can_be_en_passant
    else
      @moves.each do |moveset|
        if move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1]
          if moveset == [0, -1]
            return true if board_state[finish.to_sym].nil?
          elsif moveset == [0, -2]
            return false unless @first_move
            @can_be_en_passant = true
            return true
          elsif moveset == [-1, -1] || moveset == [1, -1]
            unless board_state[finish.to_sym].nil? || !board_state[finish.to_sym].is_white
              return true
            end
          end
        end
      end
    end
    false
  end

  def find_potential_moves(board_state)
    @potential_moves = potential_move_list(@moves, @position, @is_white, board_state)
  end
end
