require "pieces/pawn"

describe Pawn do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "initializing to correct color" do
    context "when first player" do
      it "creates white pawn piece" do
        expect(board_state[:a2].icon).to eql("P".white)
      end
    end
  end
  describe "#in_moveset?" do
    context "when chosen move is 1 space forward" do
      it "returns true" do
        expect(board_state[:a2].in_moveset?([[2,1], [2,2]], board_state)).to be_truthy
      end
    end
    context "when chosen move is 2 spaces forward and it's first move" do
      it "returns true" do
        expect(board_state[:a2].in_moveset?([[2,1], [2,3]], board_state)).to be_truthy
      end
    end
    context "when chosen move is 2 spaces forward and it's not first move" do
      it "returns false" do
        board_state[:a2].instance_variable_set(:@first_move, false)
        expect(board_state[:a2].in_moveset?([[2,1], [2,3]], board_state)).to be_falsey
      end
    end
    context "when chosen move is 3 spaces forward" do
      it "returns false" do
        expect(board_state[:a2].in_moveset?([[2,1], [2,4]], board_state)).to be_falsey
      end
    end
  end
end