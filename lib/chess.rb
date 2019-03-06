require_relative '../lib/board'
require_relative '../lib/chess_strings'


class Chess
  include ChessStrings

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

run_game
