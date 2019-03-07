require 'chess'
require 'board'

describe Chess do
  subject(:chess) { Chess.new }
  describe "#game_end" do
    let(:game_over) { subject.instance_variable_set(:@game_over, checkmate: true) }
    context "when @game_over indicates either stalemate or checkmate" do
      xit "displays winner and ends the game" do

      end
    end
  end
end