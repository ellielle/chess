require "pieces/knight"

describe Knight do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "initializing to correct color" do
    context "when first player" do
      it "creates white knight piece" do
        expect(board_state[:b1].icon).to eql("K".white)
      end
    end
  end
  describe "#in_moveset?" do
    context "when chosen move is allowed" do
      it "returns true" do
        expect(board_state[:b1].in_moveset?([[2,1], [3,3]], board_state)).to be_truthy
      end
    end
    context "when chosen move isn't allowed" do
      it "returns false" do
        expect(board_state[:b1].in_moveset?([[2,1], [7,4]], board_state)).to be_falsey
      end
    end
    context "when chosen space already has a piece" do
      it "returns false" do
        expect(board_state[:b1].in_moveset?([[2,1], [4,2]], board_state)).to be_falsey
      end
    end
    context "when chosen space already has a piece of the opposite color" do
      it "returns true" do
        board_state[:d2] = board_state[:b8]
        expect(board_state[:b1].in_moveset?([[2,1], [4,2]], board_state)).to be_truthy
      end
    end
  end
  describe "#find_potential_moves" do
    context "when called on a fresh board" do
      it "returns the two possible moves" do
        expect(board_state[:b1].find_potential_moves(board_state)).to have_key([1, 3])
        expect(board_state[:b1].find_potential_moves(board_state)).to have_key([3, 3])
      end
    end
    context "when called after a move to a3" do
      it "returns the list of spaces that are valid moves" do
        board_state[:b1].position = [1, 3]
        expect(board_state[:b1].find_potential_moves(board_state)).to have_key([3, 4])
        expect(board_state[:b1].find_potential_moves(board_state)).to have_key([2, 5])
      end
    end
  end
end