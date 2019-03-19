require_relative '../../lib/board'
require_relative '../../lib/convert'

class Pawn
  include ConvertCoordinates

  attr_accessor :position
  attr_reader :moves, :icon, :is_white

  def initialize(position, is_white)
    @moves = is_white ? white_moves : black_moves
    @position = position
    @icon = is_white ? "P".white : "P".black
    @is_white = is_white
    @can_be_en_passant = false
    @first_move = true
    #TODO en passant & promotion
    #TODO set first_move to false after move
  end

  def white_moves
    hsh = { normal: [0,1],
            two: [0,2],
            en_passant: [[1,1],[1,-1]],
            take: [[1,1],[1,-1]]
    }
  end

  def black_moves
    hsh = { normal: [0,-1],
            two: [0,-2],
            en_passant: [[-1,-1],[-1,1]],
            take: [[-1,-1],[-1,1]]
    }
  end
#TODO unset enpassant on next move if it's set to true
  def in_moveset?(move)
    start = convert_number_to_position(move[0])
    finish = convert_number_to_position(move[1])
    if @is_white
      @moves.each do |key, value|
        if key == :normal
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            @can_be_en_passant = false if @can_be_en_passant
            return true
          end
        elsif key == :two && @first_move
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            @first_move = false
            @can_be_en_passant = true
            return true
          end
        elsif key == :take
          value.each do |v|
            if move[0][0] + v[0] == move[1][0] && move[0][1] + v[1] == move[1][1]
              @can_be_en_passant = false if @can_be_en_passant
              return true
            end
          end
        end
      end
    else
      @moves.each do |key, value|
        if key == :normal
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            @can_be_en_passant = false if @can_be_en_passant
            return true
          end
        elsif key == :two && @first_move
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            @first_move = false
            @can_be_en_passant = true
            return true
          end
        elsif key == :take
          value.each do |v|
            if move[0][0] + v[0] == move[1][0] && move[0][1] + v[1] == move[1][1]
              @can_be_en_passant = false if @can_be_en_passant
              return true
            end
          end
        end
      end
    end
    false
  end
end
