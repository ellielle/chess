require "pieces/pawn"

describe Pawn do
  subject(:white_pawn) { Pawn.new([2,1], true) }
  subject(:black_pawn) { Pawn.new([7,1], false) }
  before(:all) { system("cls") }
  describe "initializing to correct color" do
    context "when first player" do
      it "creates white pawn piece" do
        expect(white_pawn.icon).to eql("♙")
      end
    end
  end
end