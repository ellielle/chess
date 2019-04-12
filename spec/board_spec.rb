require 'board'
require 'string'

describe Board do
  subject(:board) { Board.new("p1", "p2") }
  let(:board_state) { subject.instance_variable_get(:@board_state) }
  describe "#create_board" do
    before { subject.create_board }
    context "when initialized" do
      it "creates hash of proper size" do
        expect(board_state).to include(:a1, :a8, :d5, :h8)
      end
      it "fills hash with proper values" do
        expect(board_state).to include(a1: nil, a8: nil, d5: nil, h8: nil)
      end
    end
  end
  describe "#place_white_pieces" do
    before { subject.place_white_pieces }
    context "when run" do
      it "places white knights in first row" do
        expect(board_state[:b1].icon).to eql("K".white)
        expect(board_state[:g1].icon).to eql("K".white)
      end
      it "places white bishops in first row" do
        expect(board_state[:c1].icon).to eql("B".white)
        expect(board_state[:f1].icon).to eql("B".white)
      end
    end
  end
  describe "#place_white_pawns" do
    before { subject.place_white_pawns }
    context "when run" do
      it "places the row of white pawns" do
        expect(board_state[:a2].icon).to eql("P".white)
        expect(board_state[:h2].icon).to eql("P".white)
      end
    end
  end
  describe "#place_black_pieces" do
    before { subject.place_black_pieces }
    context "when run" do
      it "places black knights in first row" do
        expect(board_state[:b8].icon).to eql("K".black)
        expect(board_state[:g8].icon).to eql("K".black)
      end
    end
  end
  describe "#place_black_pawns" do
    before { subject.place_black_pawns }
    context "when run" do
      it "places black pawns in second row" do
        expect(board_state[:a7].icon).to eql("P".black)
        expect(board_state[:h7].icon).to eql("P".black)
      end
    end
  end
  describe "#move_piece" do
    context "when using the move b2 to b4" do
      it "moves the pawn at b2 to b4" do
        subject.move_piece("b2, b4", "p1")
        expect(board_state[:b4].position).to eql([2, 4])
      end
      it "removes the pawn from b2" do
        subject.move_piece("b2, b4", "p1")
        expect(board_state[:b2]).to be_nil
      end
    end
  end
  describe "#convert_number_to_position" do
    context "when passed in number coordinates" do
      it "returns the letter & number for the board coordinate" do
        move = subject.convert_number_to_position([2, 3])
        expect(move).to eql("b3")
      end
    end
  end
  describe "#in_check?" do
    context "when a player's King is in check" do
      it "returns true" do
        board_state.each do |k,v|
          unless v.is_a?(King) || v.is_a?(Queen) || v.nil?
            board_state[k] = nil
          end
        end
        board_state[:f7] = board_state[:d1]
        board_state[:d1] = nil
        board_state[:f7].position = [6, 7]
        subject.move_piece("f7, f8", "p1")
        expect(subject.in_check?("p1")).to be_truthy
      end
    end
    context "when #check_checkmate returns true" do
      it "calls #game_end and announces the winner" do
        board_state.each do |k,v|
          unless v.is_a?(King)
            board_state[k] = nil
          end
        end
        subject.move_piece("e8, d8", "p1")
        subject.move_piece("d8, e8", "p1")
        board_state[:c8] = Rook.new([3, 8], true)
        subject.move_piece("c8, d8", "p1")
        board_state[:c7] = Rook.new([3, 7], true)
        subject.move_piece("c7, d7", "p1")
        board_state[:g8] = Rook.new([7, 8], true)
        subject.move_piece("g8, f8", "p1")
        board_state[:g7] = Rook.new([7, 7], true)
        subject.move_piece("g7, f7", "p1")
        board_state[:e6] = Rook.new([6, 6], true)
        subject.move_piece("e6, e7", "p1")
        expect(subject.in_check?("p1")).to be_truthy
      end
    end
  end
  describe "#check_checkmate?" do
    context "when a player's King is unable to move" do
      it "returns true" do
        board_state.each do |k,v|
          unless v.is_a?(King)
            board_state[k] = nil
          end
        end
        subject.move_piece("e8, d8", "p1")
        subject.move_piece("d8, e8", "p1")
        board_state[:c8] = Rook.new([3, 8], true)
        subject.move_piece("c8, d8", "p1")
        board_state[:c7] = Rook.new([3, 7], true)
        subject.move_piece("c7, d7", "p1")
        board_state[:g8] = Rook.new([7, 8], true)
        subject.move_piece("g8, f8", "p1")
        board_state[:g7] = Rook.new([7, 7], true)
        subject.move_piece("g7, f7", "p1")
        board_state[:e6] = Rook.new([6, 6], true)
        subject.move_piece("e6, e7", "p1")
        expect(subject.check_checkmate?("p2")).to be_truthy
      end
    end
  end
  describe "#promote_pawn_check" do
    context "when a white pawn makes it to the 8th rank" do
      it "allows user to promote the pawn to another piece" do
        board_state.each { |k, v| board_state[k] = nil unless v.is_a?(Pawn) && v.is_white }
        board_state[:a8] = board_state[:a2]
        board_state[:a8].position = [1, 8]
        allow(subject).to receive(:gets).and_return('q')
        subject.promote_pawn_check("a8")
        expect(board_state[:a8]).to be_a(Queen)
      end
    end
  end
  describe "#check_stalemate" do
    context "when a player has no legal moves" do
      it "sets @game_over[:stalemate] to true" do
        board_state.each { |k, v| board_state[k] = nil unless v.is_a?(King) || v.is_a?(Queen) }
        board_state[:e8] = nil
        board_state[:a5] = board_state[:d8]
        board_state[:d8] = nil
        board_state[:a5].position = [1, 5]
        board_state[:c6] = board_state[:e1]
        board_state[:e1] = nil
        board_state[:c6].position = [3, 6]
        board_state[:c4] = board_state[:d1]
        board_state[:d1] = nil
        board_state[:c4].position = [3, 4]
        subject.instance_variable_set(:@player1, "p1")
        subject.check_stalemate("p2")
        gameover = subject.instance_variable_get(:@game_over)
        expect(gameover[:stalemate]).to be_truthy
      end
    end
  end
end
