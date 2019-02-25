require_relative 'chess'
require_relative 'string'

class Board
  def initialize
    @positions = Hash.new{ |hsh, key| hsh[key] = [] } #first element of array is instance of piece, second is board color
    @valid_squares = []
    create_board
    place_pieces
  end

  def create_board
    color = %w{ black white } #array to alternate background colors of the board with :reverse!
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        @positions["#{horizontal + vertical.to_s}".to_sym][0] = nil
        @positions["#{horizontal + vertical.to_s}".to_sym][1] = color[0]
        color.reverse!
      end
      color.reverse!
    end
    #TODO add outline and pieces
  end

  def place_pieces
    place_white_pieces
    place_white_pawns
    place_black_pieces
    place_black_pawns
  end

  def place_white_pieces
    @positions[:a1][0] = Rook.new([1,1], true)
    @positions[:b1][0] = Knight.new([2,1], true)
    @positions[:c1][0] = Bishop.new([3,1], true)
    @positions[:d1][0] = Queen.new([4,1], true)
    @positions[:e1][0] = King.new([5,1], true)
    @positions[:f1][0] = Bishop.new([6,1], true)
    @positions[:g1][0] = Knight.new([7,1], true)
    @positions[:h1][0] = Rook.new([8,1], true)
  end

  def place_white_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @positions["#{x_coordinate}2".to_sym][0] = Pawn.new([num, 2], true)
      x_coordinate.succ!
    end
  end

  def place_black_pieces
    @positions[:a8][0] = Rook.new([1,8], false)
    @positions[:b8][0] = Knight.new([2,8], false)
    @positions[:c8][0] = Bishop.new([3,8], false)
    @positions[:d8][0] = Queen.new([4,8], false)
    @positions[:e8][0] = King.new([5,8], false)
    @positions[:f8][0] = Bishop.new([6,8], false)
    @positions[:g8][0] = Knight.new([7,8], false)
    @positions[:h8][0] = Rook.new([8,8], false)
  end

  def place_black_pawns
    x_coordinate = "a"
    1.upto(8) do |num|
      @positions["#{x_coordinate}7".to_sym][0] = Pawn.new([num, 7], false)
      x_coordinate.succ!
    end
  end

  def display
    top_border
    display_pieces
    bottom_border
  end
  
  def top_border
    puts " ┌────┬────┬────┬────┬────┬────┬────┬────┐"
  end

  def bottom_border
    puts " └────┴────┴────┴────┴────┴────┴────┴────┘"
  end

  def display_pieces
    count = 8
    char = "h"
    str = ""
    1.upto(8) do |num|
      print "#{count}"
      until char < "a" do
        if @positions[(char + num.to_s).to_sym][0].nil?
          str =  @positions[(char + num.to_s).to_sym][1] == "black" ? "|    " :
                    "|#{"    ".white_background}"
          print str
        else
          str = @positions[(char + num.to_s).to_sym][1] == "black" ?
                    "| #{@positions[(char + num.to_s).to_sym][0].icon} " :
                    "| #{@positions[(char + num.to_s).to_sym][0].icon} ".white_background
          print str
        end
        char.prev!
      end
      puts "|"
      char = "h"
      count -= 1
      separate unless count == 0
    end
  end

  def separate
    puts " ├────┼────┼────┼────┼────┼────┼────┼────┤"
  end
end