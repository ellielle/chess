require_relative '../lib/board'

class Chess
  include ChessStrings

  def initialize
    @game = Board.new
    @player1 = nil
    @player2 = nil
    @turn = player_names
    game_loop
  end

  def intro
    introduction_text
  end

  def player_names
    #TODO remove names and add prompt for names
    puts "\nEnter player 1's name: "
    @player1 = "Ellie"
    puts "Now enter player 2's name: "
    @player2 = "Canada"
    [@player1, @player2]
  end

  def game_loop
    intro
    loop do

    end
  end

  def game_end
    #TODO TEXT
    exit
  end

  def change_turn
    @turn.reverse!
  end
end
