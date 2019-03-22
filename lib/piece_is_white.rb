module PieceIsWhite
  def landing_piece_is_white?(is_white, move, space, board_state)
    if is_white && !board_state[convert_number_to_position([move, space]).to_sym].nil?
      return true if board_state[convert_number_to_position([move, space]).to_sym].is_white
      return false
    elsif !is_white && !board_state[convert_number_to_position([move, space]).to_sym].nil?
      return true unless board_state[convert_number_to_position([move, space]).to_sym].is_white
      return false
    end
  end
end