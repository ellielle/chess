require "pieces/rook"

describe Rook do
  subject(:board) { Board.new("Ellie", "Canada") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#in_moveset?" do
    context "when chosen move is allowed" do
      it "returns true" do
        expect(board_state["a1".to_sym].in_moveset?([[1,1], [1,6]], board_state)).to be_truthy
        expect(board_state["a8".to_sym].in_moveset?([[1,8], [1,3]], board_state)).to be_truthy
      end
    end
  end
end