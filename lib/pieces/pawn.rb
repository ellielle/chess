require_relative '../../lib/board'

class Pawn
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

  def in_moveset?(move)
    if @is_white
      @moves.each do |key, value|
        if key == :two
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            @first_move = false
            return true
          end
        elsif key == :take
          if move[0][0] + value[0] == move[1][0] && move[0][1] + value[1] == move[1][1]
            #TODO FINISH
          end
        end
      end
    end
    move[0][0] + moveset[0] == move[1][0] && move[0][1] + moveset[1] == move[1][1]
  end
end
