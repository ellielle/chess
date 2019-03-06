module ChessStrings
  def introduction_text
    puts <<~INTRO
      Welcome to command line chess! Basic rules can be found at:
      https://en.wikipedia.org/wiki/Chess
      Player 1 will go first, and will control the pieces at the bottom of the board.
    INTRO
  end
  def pawn_promotion; end  #TODO might need to pass in instance of Pawn
  def check; end
  def check_mate; end
  def stalemate; end
end
