require_relative '../lib/board'

class Chess
  include ChessStrings

  def initialize
    @game = Board.new
    @player1 = nil
    @player2 = nil
    @turn = %w(@player1 @player2)
    intro
  end

  def intro
    introduction_text
    player_names

  end

  def player_names
    #TODO remove names and add prompt for names
    print "\nEnter player 1's name: "
    @player1 = "Ellie"
    print "\nNow enter player 2's name: "
    @player2 = "Canada"
  end

  def change_turn
    @turn.reverse!
  end
end

def run_game
  run = Chess.new
end

run_game
