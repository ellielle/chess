require "pieces/knight"

describe Knight do
  subject(:board) { Board.new("Ellie", "Canada") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "initializing to correct color" do
    context "when first player" do
      it "creates white knight piece" do
        expect(board_state["b1".to_sym].icon).to eql("K".white)
      end
    end
  end
  describe "#in_moveset?" do
    context "when chosen move is allowed" do
      it "returns true" do
        expect(board_state["b1".to_sym].in_moveset?([[2,1], [3,3]], board_state)).to be_truthy
      end
    end
    context "when chose move isn't allowed" do
      it "returns false" do
        expect(board_state["b1".to_sym].in_moveset?([[2,1], [7,4]], board_state)).to be_falsey
      end
    end
  end
end