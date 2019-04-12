require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'string'
require_relative 'chess_strings'

class Board
  include ConvertCoordinates, ChessStrings

  attr_reader :game_over, :check, :board_state

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board_state = Hash.new(nil)
    @game_over = {checkmate: false, stalemate: false} #TODO
    @check = false
    @last_move = nil
    create_board
    place_pieces
    initialize_potential_moves
  end

  def create_board
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        @board_state["#{horizontal + vertical.to_s}".to_sym] = nil
      end
    end
  end

  def initialize_potential_moves
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        unless @board_state["#{horizontal + vertical.to_s}".to_sym].nil?
          @board_state["#{horizontal + vertical.to_s}".to_sym].find_potential_moves(board_state = @board_state)
        end
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
    char = "a"
    8.downto(1) do |num|
      print "#{count} "
      until char > "h" do
        if @board_state[(char + num.to_s).to_sym].nil?
          print "|   "
        else
          print "| #{@board_state[(char + num.to_s).to_sym].icon} "
        end
        char.next!
      end
      puts "| #{count}"
      char = "a"
      count -= 1
      separate unless count == 0
    end
  end

  def valid_move?(move, turn)
    move = split_move_into_array(move)
    start = move[0]
    finish = move[1]
    return false unless space_exists?(start)
    return false unless space_exists?(finish)
    return false unless player_owns_piece?(start, turn)
    return false unless space_empty_or_enemy?(start, finish)
    return false unless move_in_moveset?(start, finish)
    stalemate?(turn)
    true
  end

  def split_move_into_array(move)
    move.gsub(' ', '').split(",")
  end

  def player_owns_piece?(piece, turn)
    return false if @board_state[piece.to_sym].nil?
    return true if @player1 == turn && @board_state[piece.to_sym].is_white
    return true if @player2 == turn && !@board_state[piece.to_sym].is_white
    false
  end

  def space_exists?(position)
    return false if position.nil?
    return true if @board_state.key?(position.to_sym)
    false
  end

  def space_empty_or_enemy?(piece, position)
    if @board_state[piece.to_sym].is_white
      return true if @board_state[position.to_sym].nil? || !@board_state[position.to_sym].is_white
    elsif !@board_state[piece.to_sym].is_white
      return true if @board_state[position.to_sym].nil? || @board_state[position.to_sym].is_white
    end
    false
  end

  def move_in_moveset?(start, finish)
    move = [convert_position_to_number(start), convert_position_to_number(finish)]
    @board_state[start.to_sym].in_moveset?(move, board_state = @board_state)
  end

  def move_piece(move, turn)
    move = split_move_into_array(move)
    @board_state[move[1].to_sym] = @board_state[move[0].to_sym]
    @board_state[move[1].to_sym].position = convert_position_to_number(move[1])
    @board_state[move[0].to_sym] = nil
    @board_state[move[1].to_sym].find_potential_moves(board_state = @board_state)
    @last_move = @board_state[move[1].to_sym]
    promote_pawn_check(move[1]) if @last_move.is_a?(Pawn) && !in_check?(turn)
    in_check?(turn) if @check
    King.get_possible_moves(board_state = @board_state)
  end

  def in_check?(turn)
    @last_move.potential_moves.compact.each_value do |value|
      if value.is_a?(King)
        @check = true
        @game_over[:checkmate] = true if check_checkmate?(turn)
        return true
      end
    end
    @game_over[:checkmate] = false if @game_over[:checkmate]
    @check = false
    false
  end

  def check_checkmate?(turn)
    #TODO fix not allowing a move and immediately calling checkmate
    check_moves = []
    king = nil
    @board_state.each_value do |piece|
      next if piece.nil?
      if piece.is_a?(King)
        if piece.is_white && turn == @player1
          king = piece.potential_moves
        elsif !piece.is_white && turn == @player2
          king = piece.potential_moves
        end
      else
        piece&.potential_moves&.each_key { |k| check_moves.push(k) }
        check_moves << piece.position
      end
    end
    check_moves&.compact!
    check_moves&.uniq!
    begin
      king.each do |position|
        king.delete(position[0]) if check_moves.include?(position[0])
      end
    ensure
      return true if king.empty?
    end
    false
  end

  def promote_pawn_check(piece)
    if @board_state[piece.to_sym].position[1] == 8 && @board_state[piece.to_sym].is_white
      pawn_promotion("white", piece)
    elsif @board_state[piece.to_sym].position[1] == 1 && !@board_state[piece.to_sym].is_white
      pawn_promotion("black", piece)
    end
  end

  def pawn_promotion(color, piece)
    pos = @board_state[piece.to_sym].position
    is_white = color == "white" ? true : false
    valid_input = false
    until valid_input
      valid_input = true
      pawn_promotion_text
      choice = gets.chomp
      choice&.downcase!
      case choice
      when 'b'
        @board_state[piece.to_sym] = Bishop.new(pos, is_white)
        @board_state[piece.to_sym].find_potential_moves(board_state = @board_state)
      when 'q'
        @board_state[piece.to_sym] = Queen.new(pos, is_white)
        @board_state[piece.to_sym].find_potential_moves(board_state = @board_state)
      when 'r'
        @board_state[piece.to_sym] = Rook.new(pos, is_white)
        @board_state[piece.to_sym].find_potential_moves(board_state = @board_state)
      when 'k'
        @board_state[piece.to_sym] = Knight.new(pos, is_white)
        @board_state[piece.to_sym].find_potential_moves(board_state = @board_state)
      else
        puts "Invalid input."
        valid_input = false
      end
    end
  end

  def stalemate?(turn)
    board_state = @board_state.compact
    is_white = turn == @player1 ? true : false
    can_move = true
    board_state.each_value do |value|
      next if is_white && !value.is_white
      next if !is_white && value.is_white
      can_move = value.potential_moves.empty? ? false : true
    end
    @game_over[:stalemate] = true unless can_move
  end
end
