require "pieces/pawn"

describe Pawn do
  subject(:white_pawn) { Pawn.new([1,2], true) }
  subject(:black_pawn) { Pawn.new([1,7], false) }
  describe "initializing to correct color" do
    context "when first player" do
      let(:icon) { white_pawn.instance_variable_get(:@icon) }
      it "creates white pawn piece" do
        expect(icon).to eql("P".white)
      end
    end
  end
end