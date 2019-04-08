require_relative '../lib/board'

class Chess
  include ChessStrings

  def initialize
    @player1 = nil
    @player2 = nil
    @winner = nil
    intro
    @turn = player_names
    @game = Board.new(@player1, @player2)
    game_loop
  end

  def intro
    introduction_text
  end

  def player_names
    #TODO remove names and add prompt for names
    puts "Enter player 1's name: "
    @player1 = "p1"
    puts "Now enter player 2's name: "
    @player2 = "p2"
    [@player1, @player2]
  end

  def game_loop
    move = nil
    valid_move = false
    loop do
      system("cls")
      @game.display
      until valid_move && @game.check == false
        puts "\n#{@turn[0]}'s turn. Enter your move in the format: 'b2, b4':"
        puts "\n#{@turn[0]}'s King is in check!" if @game.check
        #TODO gets.chomp
        move = "b1, c3"
        game_end(true) if move == "exit"
        save_game if move == "save"
        valid_move = @game.valid_move?(move, @turn[0])
        @game.move_piece(move) if valid_move
        invalid_move_text unless valid_move
      end
      @game.in_check?(@turn[1] == @player1 ? "p1" : "p2")
      change_turn
      valid_move = false
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

  def load_game; end
  def save_game; end

end
#TODO ADD SAVE AND RESUME FUNCTIONALITY
