require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/king'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/rook'
require_relative '../lib/chess_strings'

class Chess
  def initialize
    @game = Board.new
    start_game
  end

  def start_game
    introduction
  end
end

def run_game
  run = Chess.new
end