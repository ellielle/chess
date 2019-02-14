class Board
  def initialize
    @positions = Hash.new{ |hsh, key| hsh[key] = [] }
    @valid_squares = []
    create_board
    #place_pieces
  end

  def create_board
    color = %w{ black white }
    ('a'..'h').each do |horizontal|
      (1..8).each do |vertical|
        @positions["#{horizontal + vertical.to_s}".to_sym][0] = nil
        @positions["#{horizontal + vertical.to_s}".to_sym][1] = color[0]
        color.reverse!
      end
      color.reverse!
    end
    #TODO add outline and pieces
  end

end