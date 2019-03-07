module ChessStrings
  def introduction_text
    text = %Q(
      Welcome to command line chess! Basic rules can be found at:
      https://en.wikipedia.org/wiki/Chess
      Player 1 will go first, and will control the pieces at the bottom of the board.
    )
    puts text.gsub(/^#{text.scan(/^[ \t]+(?=\S)/).min}/, '')
  end
  def pawn_promotion; end  #TODO will need to pass specific pawn instance into method in board.rb

  def check
    puts "#{@turn[0]}'s king is in check."
  end

  def check_invalid_move
    puts "Invalid move. #{@turn[0]}'s king is still in check."
  end

  def check_mate

  end
  def stalemate; end
end
