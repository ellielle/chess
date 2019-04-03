module PieceMethods
  def landing_piece_is_white?(is_white, move, space, board_state)
    pos = convert_number_to_position([move, space]).to_sym
    unless board_state[pos].nil?
      return true if board_state[pos].is_white
    end
    return false if is_white
    return true if !is_white
  end

  def potential_moves(moves, position, is_white, board_state)
    return potential_pawn_moves(moves, position, is_white, board_state) if self.is_a?(Pawn)
    possible_moves = {}
    moves.each do |move|
      pos = [move[0] + position[0], move[1] + position[1]]
      next if pos[0] <= 0 || pos[0] > 8
      next if pos[1] <= 0 || pos[1] > 8
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

  def potential_pawn_moves(moves, position, is_white, board_state)
    #TODO implement
  end
end