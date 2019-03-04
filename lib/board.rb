require_relative 'chess'
require_relative 'string'

class Board
  def initialize
    @positions = Hash.new(nil)
    @valid_squares = []
    create_board
    place_pieces
  end

  def create_board
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        @positions["#{horizontal + vertical.to_s}".to_sym] = nil
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
    @positions[:a1] = Rook.new([1,1], true)
    @positions[:b1] = Knight.new([2,1], true)
    @positions[:c1] = Bishop.new([3,1], true)
    @positions[:d1] = Queen.new([4,1], true)
    @positions[:e1] = King.new([5,1], true)
    @positions[:f1] = Bishop.new([6,1], true)
    @positions[:g1] = Knight.new([7,1], true)
    @positions[:h1] = Rook.new([8,1], true)
  end

  def place_white_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @positions["#{x_coordinate}2".to_sym] = Pawn.new([num, 2], true)
      x_coordinate.next!
    end
  end

  def place_black_pieces
    @positions[:a8] = Rook.new([1,8], false)
    @positions[:b8] = Knight.new([2,8], false)
    @positions[:c8] = Bishop.new([3,8], false)
    @positions[:d8] = Queen.new([4,8], false)
    @positions[:e8] = King.new([5,8], false)
    @positions[:f8] = Bishop.new([6,8], false)
    @positions[:g8] = Knight.new([7,8], false)
    @positions[:h8] = Rook.new([8,8], false)
  end

  def place_black_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @positions["#{x_coordinate}7".to_sym] = Pawn.new([num, 7], false)
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
        if @positions[(char + num.to_s).to_sym].nil?
          print "|   "
        else
          print "| #{@positions[(char + num.to_s).to_sym].icon} "
        end
        char.prev!
      end
      puts "| #{count}"
      char = "h"
      count -= 1
      separate unless count == 0
    end
  end
end