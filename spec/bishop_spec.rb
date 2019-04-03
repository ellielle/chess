require "pieces/bishop"

describe Bishop do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#in_moveset?" do
    context "when moving down and to the left with no pieces in the way" do
      it "returns true" do
        expect(board_state[:c1].in_moveset?([[6, 6], [3, 3]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[6, 6], [3, 3]], board_state)).to be_truthy
      end
    end
    context "when trying to move any direction other than diagonally" do
      it "returns false" do
        expect(board_state[:c1].in_moveset?([[4, 4], [1, 2]], board_state)).to be_falsey
        expect(board_state[:c8].in_moveset?([[5, 4], [2, 2]], board_state)).to be_falsey
      end
    end
    context "when moving up and to the right with no pieces in the way" do
      it "returns true" do
        expect(board_state[:c1].in_moveset?([[3, 3], [6, 6]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[3, 3], [6, 6]], board_state)).to be_truthy
      end
    end
    context "when moving up and to the left with no pieces in the way" do
      it "returns true" do
        expect(board_state[:c1].in_moveset?([[3, 3], [1, 5]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[3, 3], [1, 5]], board_state)).to be_truthy
      end
    end
    context "when moving down and to the right with no pieces in the way" do
      it "returns true" do
        expect(board_state[:c1].in_moveset?([[3, 6], [6, 3]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[3, 6], [6, 3]], board_state)).to be_truthy
      end
    end
  end
  describe "#path_clear?" do
    context "when another piece is in the path of the move" do
      it "returns false" do
        expect(board_state[:c1].in_moveset?([[3, 6], [7, 2]], board_state)).to be_falsey
        expect(board_state[:c8].in_moveset?([[7, 2], [1, 7]], board_state)).to be_falsey
      end
    end
    context "when the landing space has other player's piece" do
      it "returns true" do
        expect(board_state[:c1].in_moveset?([[7, 2], [2, 7]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[2, 7], [7, 2]], board_state)).to be_truthy
        expect(board_state[:c1].in_moveset?([[1, 2], [6, 7]], board_state)).to be_truthy
        expect(board_state[:c8].in_moveset?([[8, 7], [3, 2]], board_state)).to be_truthy
      end
    end
  end
  describe "#find_potential_moves" do
    context "when called on a fresh board" do
      it "returns an empty list since the bishop is stuck" do
        expect(board_state[:c1].find_potential_moves(board_state)).to be_empty
        expect(board_state[:c8].find_potential_moves(board_state)).to be_empty
      end
    end
    context "when called without pawn in the way" do
      it "returns the list of empty spaces that are valid moves" do
        board_state[:b2] = nil
        board_state[:d2] = nil
        board_state[:b7] = nil
        board_state[:d7] = nil
        expect(board_state[:c1].find_potential_moves(board_state)).to have_key([6,4])
        expect(board_state[:c1].find_potential_moves(board_state)).to have_key([1,3])
        expect(board_state[:c8].find_potential_moves(board_state)).to have_key([7,4])
        expect(board_state[:c8].find_potential_moves(board_state)).to have_key([1,6])
      end
    end
  end
end