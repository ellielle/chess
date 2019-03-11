require_relative '../lib/board'

class Chess
  include ChessStrings

  def initialize
    @game = Board.new
    @player1 = nil
    @player2 = nil
    @winner = nil
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
    valid_move = false
    loop do
      game_end(true) if move == "exit"
      @game.display
      until valid_move
        puts "\n#{@turn[0]}'s turn. Enter your move in the format: b2,b4"
        move = gets.chomp
        valid_move = check_move_validity #TODO
        invalid_move_text unless valid_move
      end
    end
  end

  def game_end(quit = false)
    puts "#{@winner} has won the game. Press ENTER to exit." unless quit
    puts "#{@turn[0]} has forfeited the game. Press ENTER to exit." if quit
    gets
    exit
  end

  def change_turn
    @turn.reverse!
  end
end
