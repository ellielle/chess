require "pieces/queen"

describe Queen do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#in_moveset?" do
    context "when moving up/down/left/right" do
      it "returns true" do
        expect(board_state[:d1].in_moveset?([[1, 6], [1, 3]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[1, 6], [8, 6]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[1, 3], [1, 6]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[8, 6], [1, 6]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[1, 6], [1, 3]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[1, 6], [8, 6]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[1, 3], [1, 6]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[8, 6], [1, 6]], board_state)).to be_truthy
      end
    end
    context "when moving diagonally" do
      it "returns true" do
        expect(board_state[:d1].in_moveset?([[1, 6], [4, 3]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[8, 6], [5, 3]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[6, 3], [8, 5]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[3, 3], [1, 5]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[1, 6], [4, 3]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[8, 6], [5, 3]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[6, 3], [8, 5]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[3, 3], [1, 5]], board_state)).to be_truthy
      end
    end
    context "when move is invalid" do
      it "returns false" do
        expect(board_state[:d1].in_moveset?([[1, 3], [2, 5]], board_state)).to be_falsey
        expect(board_state[:d1].in_moveset?([[4, 3], [1, 8]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[8, 3], [1, 4]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[6, 6], [1, 3]], board_state)).to be_falsey
      end
    end
  end
  describe "#path_clear?" do
    context "when another piece is in the path of an up/down/left/right movement" do
      it "returns false" do
        expect(board_state[:d1].in_moveset?([[4, 1], [4, 2]], board_state)).to be_falsey
        expect(board_state[:d1].in_moveset?([[4, 1], [3, 1]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[4, 8], [3, 8]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[4, 8], [4, 7]], board_state)).to be_falsey
      end
    end
    context "when another piece is in the path of a diagonal movement" do
      it "returns false" do
        expect(board_state[:d1].in_moveset?([[4, 1], [7, 4]], board_state)).to be_falsey
        expect(board_state[:d1].in_moveset?([[4, 1], [2, 3]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[4, 8], [8, 4]], board_state)).to be_falsey
        expect(board_state[:d8].in_moveset?([[4, 8], [1, 5]], board_state)).to be_falsey
      end
    end
    context "when landing on the other player's piece" do
      it "returns true" do
        expect(board_state[:d1].in_moveset?([[4, 4], [4, 7]], board_state)).to be_truthy
        expect(board_state[:d1].in_moveset?([[4, 4], [7, 7]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[4, 4], [4, 2]], board_state)).to be_truthy
        expect(board_state[:d8].in_moveset?([[4, 4], [2, 2]], board_state)).to be_truthy
      end
    end
  end
  describe "#find_potential_moves" do
    context "when called on a fresh board" do
      it "returns an empty list" do
        expect(board_state[:d1].find_potential_moves(board_state)).to be_empty
        expect(board_state[:d8].find_potential_moves(board_state)).to be_empty
      end
    end
    context "when called without any pieces in the way" do
      it "returns the list of empty spaces that are valid moves" do
        board_state[:d2] = nil
        board_state[:c2] = nil
        board_state[:e2] = nil
        board_state[:d7] = nil
        board_state[:c7] = nil
        board_state[:e7] = nil
        expect(board_state[:d1].find_potential_moves(board_state)).to have_key([4, 5])
        expect(board_state[:d1].find_potential_moves(board_state)).to have_key([1, 4])
        expect(board_state[:d1].find_potential_moves(board_state)).to have_key([8, 5])
        expect(board_state[:d8].find_potential_moves(board_state)).to have_key([4, 5])
        expect(board_state[:d8].find_potential_moves(board_state)).to have_key([1, 5])
        expect(board_state[:d8].find_potential_moves(board_state)).to have_key([8, 4])
      end
    end
  end
end