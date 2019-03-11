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

end
