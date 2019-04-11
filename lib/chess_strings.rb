module ChessStrings
  def introduction_text
    text = %Q(
      Welcome to command line chess! Basic rules can be found at:
      https://en.wikipedia.org/wiki/Chess
      Player 1 will go first, and will control the pieces at the bottom of the board.
      You may enter "save" at any time to save the current game, or "load" to load a game.
      You may enter "exit" at any time to give up and exit the game.
    )
    puts text.gsub(/^#{text.scan(/^[ \t]+(?=\S)/).min}/, '')
  end

  def pawn_promotion_text
    puts "You can now promote this pawn."
    puts "Enter 'b' for Bishop, 'q' for Queen, 'r' for Rook, or 'k' for Knight."
  end

  def check_text(turn)
    puts "#{turn}'s king is in check."
  end

  def invalid_move_check_text(turn)
    puts "Invalid move. #{turn}'s king is still in check."
  end

  def invalid_move_text
    puts "Invalid move."
  end

  def check_mate_text
    puts "Checkmate! #{@turn[0]} wins! Press ENTER to exit."
  end

  def stalemate_text
    puts "The game has ended in a stalemate. Press ENTER to exit."
    gets
  end

  def exit_quit_text
    puts "#{@turn[0]} has forfeited the game. Press ENTER to exit."
  end
end
