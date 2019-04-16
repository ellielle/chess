require_relative '../lib/board'
require 'yaml'

class Chess
  include ChessStrings

  def initialize
    @player1 = nil
    @player2 = nil
    intro
    @turn = player_names
    @game = Board.new(@player1, @player2)
    game_loop
  end

  def intro
    system("cls")
    introduction_text
  end

  def player_names
    puts "Enter player 1's name: "
    @player1 = gets.chomp
    puts "Now enter player 2's name: "
    @player2 = gets.chomp
    [@player1, @player2]
  end

  def game_loop
    valid_move = false
    loop do
      system("cls")
      @game.display
      until valid_move && @game.check == false
        puts "\n#{@turn[0]}'s turn. Enter your move in the format: 'b2, b4':"
        check_text(@turn[0]) if @game.check
        move = gets.chomp
        exit_game(true) if move == "exit"
        save_game if move == "save"
        valid_move = @game.valid_move?(move, @turn[0])
        @game.move_piece(move, @turn[0]) if valid_move
        if @game.check
          invalid_move_check_text(@turn[0]) unless valid_move
        else
          invalid_move_text unless valid_move
        end
      end
      game_end if @game.game_over[:checkmate]
      game_end_stalemate if @game.game_over[:stalemate]
      @game.in_check?(@turn[1])
      change_turn
      valid_move = false
    end
  end

  def game_end
    check_mate_text(@turn[0])
    gets
    exit
  end

  def game_end_stalemate
    stalemate_text
    gets
    exit
  end

  def exit_game(quit = false)
    exit_quit_text(@turn[0]) if quit
    gets
    exit
  end

  def change_turn
    @turn.reverse!
  end

  def save_game
    Dir.mkdir("../saves") unless Dir.exist?("../saves")
    yaml = YAML.dump(self)
    File.open("../saves/chess.yaml", "w") { |file| file.puts yaml }
    puts "Saving game. Press ENTER to exit."
    exit_game(false)
  end
end
