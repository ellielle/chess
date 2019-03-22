require "pieces/rook"

describe Rook do
  subject(:board) { Board.new("Ellie", "Canada") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#in_moveset?" do
    context "when moving up the board as a white piece" do
      it "returns true" do
        expect(board_state["a1".to_sym].in_moveset?([[1,2], [1,6]], board_state)).to be_truthy
      end
    end
    context "when moving down the board as a black piece" do
      it "returns true" do
        expect(board_state["a8".to_sym].in_moveset?([[1,7], [1,3]], board_state)).to be_truthy
      end
    end
    context "when moving to the right of the board" do
      it "returns true" do
        expect(board_state["a1".to_sym].in_moveset?([[1,3], [5,3]], board_state)).to be_truthy
      end
    end
  end
  describe "#path_clear?" do
    context "when another piece is in the path of the vertical move" do
      it "returns false" do
        expect(board_state["a1".to_sym].in_moveset?([[1,1], [1,6]], board_state)).to be_falsey
      end
    end
    context "when another piece is in the path of the horizontal move" do
      it "returns false" do
        expect(board_state["a1".to_sym].in_moveset?([[2,2], [6,2]], board_state)).to be_falsey
      end
    end
    context "when the landing space has the other place's piece" do
      it "returns true" do
        expect(board_state["a1".to_sym].in_moveset?([[1,3], [1,7]], board_state)).to be_truthy
        expect(board_state["a8".to_sym].in_moveset?([[1,7], [1,3]], board_state)).to be_truthy
        expect(board_state["a1".to_sym].in_moveset?([[1,3], [5,3]], board_state)).to be_truthy
        expect(board_state["a8".to_sym].in_moveset?([[5,3], [1,3]], board_state)).to be_truthy
      end
    end
  end
  describe "#find_potential_moves" do
    context "when called" do
      it "returns a list of all potential spaces the piece can move to" do

      end
    end
  end
end
