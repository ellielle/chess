require 'board'
require 'string'

describe Board do
  subject(:board) { Board.new("Ellie", "Canada") }
  let(:positions) { subject.instance_variable_get(:@board_state) }
  describe "#create_board" do
    before { subject.create_board }
    context "when initialized" do
      it "creates hash of proper size" do
        expect(positions).to include(:a1, :a8, :d5, :h8)
      end
      it "fills hash with proper values" do
        expect(positions).to include(a1: nil, a8: nil, d5: nil, h8: nil)
      end
    end
  end
  describe "#place_white_pieces" do
    before { subject.place_white_pieces }
    context "when run" do
      it "places white knights in first row" do
        expect(positions[:b1].icon).to eql("K".white)
        expect(positions[:g1].icon).to eql("K".white)
      end
      it "places white bishops in first row" do
        expect(positions[:c1].icon).to eql("B".white)
        expect(positions[:f1].icon).to eql("B".white)
      end
    end
  end
  describe "#place_white_pawns" do
    before { subject.place_white_pawns }
    context "when run" do
      it "places the row of white pawns" do
        expect(positions[:a2].icon).to eql("P".white)
        expect(positions[:h2].icon).to eql("P".white)
      end
    end
  end
  describe "#place_black_pieces" do
    before { subject.place_black_pieces }
    context "when run" do
      it "places black knights in first row" do
        expect(positions[:b8].icon).to eql("K".black)
        expect(positions[:g8].icon).to eql("K".black)
      end
    end
  end
  describe "#place_black_pawns" do
    before { subject.place_black_pawns }
    context "when run" do
      it "places black pawns in second row" do
        expect(positions[:a7].icon).to eql("P".black)
        expect(positions[:h7].icon).to eql("P".black)
      end
    end
  end
  xdescribe "#move_piece" do
    context "when using the move b2 to b4" do
      it "moves the pawn at b2 to b4" do
        subject.move_piece("b2, b4")
        expect(positions[:b4].position).to eql([2, 4])
      end
      it "removes the pawn from b2" do
        subject.move_piece("b2, b4")
        expect(positions[:b2]).to be_nil
      end
    end
  end
  describe "#convert_number_to_position" do
    context "when passed in number coordinates" do
      it "returns the letter & number for the board coordinate" do
        move = subject.convert_number_to_position([2, 3])
        expect(move).to eql("b3")
      end
    end
  end
end
