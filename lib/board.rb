require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'string'
require_relative 'chess_strings'

class Board
  attr_reader :game_over, :check

  def initialize
    @board_state = Hash.new(nil)
    @game_over = {checkmate: false, stalemate: false}
    @check = false
    create_board
    place_pieces
  end

  def create_board
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        @board_state["#{horizontal + vertical.to_s}".to_sym] = nil
      end
    end
  end

  def place_pieces
    place_white_pieces
    place_white_pawns
    place_black_pieces
    place_black_pawns
  end

  def place_white_pieces
    @board_state[:a1] = Rook.new([1,1], true)
    @board_state[:b1] = Knight.new([2,1], true)
    @board_state[:c1] = Bishop.new([3,1], true)
    @board_state[:d1] = Queen.new([4,1], true)
    @board_state[:e1] = King.new([5,1], true)
    @board_state[:f1] = Bishop.new([6,1], true)
    @board_state[:g1] = Knight.new([7,1], true)
    @board_state[:h1] = Rook.new([8,1], true)
  end

  def place_white_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @board_state["#{x_coordinate}2".to_sym] = Pawn.new([num, 2], true)
      x_coordinate.next!
    end
  end

  def place_black_pieces
    @board_state[:a8] = Rook.new([1,8], false)
    @board_state[:b8] = Knight.new([2,8], false)
    @board_state[:c8] = Bishop.new([3,8], false)
    @board_state[:d8] = Queen.new([4,8], false)
    @board_state[:e8] = King.new([5,8], false)
    @board_state[:f8] = Bishop.new([6,8], false)
    @board_state[:g8] = Knight.new([7,8], false)
    @board_state[:h8] = Rook.new([8, 8], false)
  end

  def place_black_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @board_state["#{x_coordinate}7".to_sym] = Pawn.new([num, 7], false)
      x_coordinate.next!
    end
  end

  def display
    top_border
    display_pieces
    bottom_border
  end

  def top_border
    puts "    a   b   c   d   e   f   g   h"
    puts "  +---+---+---+---+---+---+---+---+"
  end

  def separate
    puts "  +---+---+---+---+---+---+---+---+"
  end

  def bottom_border
    puts "  +---+---+---+---+---+---+---+---+"
    puts "    a   b   c   d   e   f   g   h"
  end

  def display_pieces
    count = 8
    char = "h"
    1.upto(8) do |num|
      print "#{count} "
      until char < "a" do
        if @board_state[(char + num.to_s).to_sym].nil?
          print "|   "
        else
          print "| #{@board_state[(char + num.to_s).to_sym].icon} "
        end
        char.prev!
      end
      puts "| #{count}"
      char = "h"
      count -= 1
      separate unless count == 0
    end
  end

  def valid_move?(move)
    #TODO ensure each player can only move their own pieces
    #TODO ensure space is either empty or piece is other color and can be taken
  end

  def promote_pawn(pawn)
    #TODO will need to pass specific pawn instance
  end
end
