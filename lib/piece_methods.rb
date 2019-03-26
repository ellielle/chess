module PieceMethods
  def landing_piece_is_white?(is_white, move, space, board_state)
    if is_white && !board_state[convert_number_to_position([move, space]).to_sym].nil?
      return true if board_state[convert_number_to_position([move, space]).to_sym].is_white
      return false
    elsif !is_white && !board_state[convert_number_to_position([move, space]).to_sym].nil?
      return true unless board_state[convert_number_to_position([move, space]).to_sym].is_white
      return false
    end
  end

  def potential_moves(moves, position, is_white, board_state)
    possible_moves = {}
    moves.each do |move|
      pos = [move[0] + position[0], move[1] + position[1]]
      next if pos[0] <= 0
      converted_pos = convert_number_to_position([pos[0], pos[1]]).to_sym
      next unless board_state.key?(converted_pos)
      next unless self.path_clear?([position, pos], board_state)
      if board_state[converted_pos].nil?
        possible_moves[pos] = board_state[converted_pos]
      elsif is_white
        next if board_state[converted_pos].is_white
        possible_moves[pos] = board_state[converted_pos]
      elsif !is_white
        next unless board_state[converted_pos].is_white
        possible_moves[pos] = board_state[converted_pos]
      end
    end
    possible_moves
  end
end