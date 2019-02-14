require "board"

describe Board do
  subject(:board) { Board.new }
  describe "#create_board" do
    let(:positions) { subject.instance_variable_get(:@positions) }
    before { subject.create_board }
    context "when initialized" do
      it "creates hash of proper size" do
        expect(positions).to include(:a1, :a8, :d5, :h8)
      end
      it "fills hash with proper values" do
        expect(positions).to include(a1: [nil, "black"], a8: [nil, "white"], d5: [nil, "white"], h8: [nil, "black"])
      end
    end
  end
  describe "#place_white_pieces" do
    context "when run" do
      xit "places the first row of white pieces" do

      end
    end
  end
  describe "#place_white_pawns" do
    context "when run" do
      xit "places the row of white pawns" do

      end
    end
  end
end