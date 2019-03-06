require "pieces/knight"

describe Knight do
  subject(:white_knight) { Knight.new([2,1], true) }
  subject(:black_knight) { Knight.new([2,8], false) }
  describe "initializing to correct color" do
    context "when first player" do
      let(:icon) { white_knight.instance_variable_get(:@icon) }
      it "creates white knight piece" do
        expect(icon).to eql("K".white)
      end
    end
  end
end