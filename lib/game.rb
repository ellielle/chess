require_relative '../lib/chess'

def load_game
  if File.exist?("../saves/chess.yaml") &&
      File.file?("../saves/chess.yaml")
    save = YAML.load_file("../saves/chess.yaml")
    game = save
    game.game_loop
  else
    puts "There are no saved games."
    start_game
  end
end

def start_game
  puts "Would you like to load your saved game? (Yn)"
  input = gets.chomp.downcase
  case input
  when "y" then load_game
  when "n" then game = Chess.new
  else
    puts "Invalid input."
    start_game
  end
end

start_game
