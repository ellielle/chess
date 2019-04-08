require 'board'
require 'string'

describe Board do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#create_board" do
    before { subject.create_board }
    context "when initialized" do
      it "creates hash of proper size" do
        expect(board_state).to include(:a1, :a8, :d5, :h8)
      end
      it "fills hash with proper values" do
        expect(board_state).to include(a1: nil, a8: nil, d5: nil, h8: nil)
      end
    end
  end
  describe "#place_white_pieces" do
    before { subject.place_white_pieces }
    context "when run" do
      it "places white knights in first row" do
        expect(board_state[:b1].icon).to eql("K".white)
        expect(board_state[:g1].icon).to eql("K".white)
      end
      it "places white bishops in first row" do
        expect(board_state[:c1].icon).to eql("B".white)
        expect(board_state[:f1].icon).to eql("B".white)
      end
    end
  end
  describe "#place_white_pawns" do
    before { subject.place_white_pawns }
    context "when run" do
      it "places the row of white pawns" do
        expect(board_state[:a2].icon).to eql("P".white)
        expect(board_state[:h2].icon).to eql("P".white)
      end
    end
  end
  describe "#place_black_pieces" do
    before { subject.place_black_pieces }
    context "when run" do
      it "places black knights in first row" do
        expect(board_state[:b8].icon).to eql("K".black)
        expect(board_state[:g8].icon).to eql("K".black)
      end
    end
  end
  describe "#place_black_pawns" do
    before { subject.place_black_pawns }
    context "when run" do
      it "places black pawns in second row" do
        expect(board_state[:a7].icon).to eql("P".black)
        expect(board_state[:h7].icon).to eql("P".black)
      end
    end
  end
  describe "#move_piece" do
    context "when using the move b2 to b4" do
      it "moves the pawn at b2 to b4" do
        subject.move_piece("b2, b4")
        expect(board_state[:b4].position).to eql([2, 4])
      end
      it "removes the pawn from b2" do
        subject.move_piece("b2, b4")
        expect(board_state[:b2]).to be_nil
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
  describe "#in_check?" do
    context "when a player's King is able to be taken on the other player's next move" do
      it "returns true" do
        board_state.each do |k,v|
          unless v.is_a?(King) || v.is_a?(Queen) || v.nil?
            board_state[k] = nil
          end
        end
        board_state[:f7] = board_state[:d1]
        board_state[:d1] = nil
        board_state[:f7].position = [6, 7]
        subject.move_piece("f7, f8")
        expect(subject.in_check?("p1")).to be_truthy
      end
    end
  end
end
