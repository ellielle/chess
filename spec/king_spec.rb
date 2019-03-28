require "pieces/king"

describe King do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#in_moveset?" do
    context "when moving 'down' one space" do
      it "returns true" do
        board_state[:e7] = nil
        expect(board_state[:e8].in_moveset?([[5,8], [5,7]], board_state)).to be_truthy
      end
    end
    context "when moving to the left one space" do
      it "returns true" do
        board_state[:d1] = nil
        expect(board_state[:e1].in_moveset?([[5,1], [4,1]], board_state)).to be_truthy
      end
    end
    context "when moving to the right with a piece in the way" do
      it "returns false" do
        expect(board_state[:e8].in_moveset?([[5,8], [6,8]], board_state)).to be_falsey
      end
    end
  end
end