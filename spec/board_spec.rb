require "board"
require "pieces/piece"
require "pieces/pawn"
require "pieces/knight"
require "pieces/king"
require "pieces/queen"
require "pieces/bishop"
require "pieces/rook"

describe Board do
  subject(:board) { Board.new }
  let(:positions) { subject.instance_variable_get(:@positions) }
  describe "#create_board" do
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
    before { subject.place_white_pieces }
    context "when run" do
      it "places white knights in first row" do
        expect(positions[:b1][0].icon).to eql("♘")
        expect(positions[:g1][0].icon).to eql("♘")
      end
      xit "places white bishops in first row" do
        expect(positions[:c1][0].icon).to eql("♗")
        expect(positions[:f1][0].icon).to eql("♗")
      end
    end
  end
  describe "#place_white_pawns" do
    before { subject.place_white_pawns }
    context "when run" do
      it "places the row of white pawns" do
        expect(positions[:a2][0].icon).to eql("♙")
        expect(positions[:h2][0].icon).to eql("♙")
      end
    end
  end
  describe "#place_black_pieces" do
    before { subject.place_black_pieces }
    context "when run" do
      it "places black knights in first row" do
        expect(positions[:b8][0].icon).to eql("♞")
        expect(positions[:g8][0].icon).to eql("♞")
      end
    end
  end
  describe "#place_black_pawns" do
    before { subject.place_black_pawns }
    context "when run" do
      it "places black pawns in second row" do
        expect(positions[:a7][0].icon).to eql("♟")
        expect(positions[:h7][0].icon).to eql("♟")
      end
    end
  end
end