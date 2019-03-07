require_relative '../lib/board'

class Chess
  include ChessStrings

  def initialize
    @game = Board.new
    @player1 = nil
    @player2 = nil
    intro
    @turn = player_names
    game_loop
  end

  def intro
    introduction_text
  end

  def player_names
    #TODO remove names and add prompt for names
    puts "Enter player 1's name: "
    @player1 = "Ellie"
    puts "Now enter player 2's name: "
    @player2 = "Canada"
    [@player1, @player2]
  end

  def game_loop
    move = nil
    loop do
      game_end(true) if move == "exit"
      @game.display
      puts "\n#{@turn[0]}'s turn. Enter your move in the format: b2,b4"
      move = gets.chomp
    end
  end

  def game_end(quit = false)
    #TODO TEXT
    puts "#{@turn[0]} has forfeited the game. Press ENTER to exit." if quit
    gets
    exit
  end

  def change_turn
    @turn.reverse!
  end
end
