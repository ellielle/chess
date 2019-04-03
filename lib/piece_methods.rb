module PieceMethods
  def landing_piece_is_white?(is_white, move, space, board_state)
    pos = convert_number_to_position([move, space]).to_sym
    unless board_state[pos].nil?
      return true if board_state[pos].is_white
      return false unless board_state[pos].is_white
    else
      return false if is_white
      return true if !is_white
    end
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

  def horizontal_path_clear?(move, board_state)
    if move[0][0] == move[1][0]
      if move[0][1] < move[1][1]
        start = move[0][1] + 1
        start.upto(move[1][1]) do |space|
          if space == move[1][1] && is_white
            return false if landing_piece_is_white?(@is_white, move[0][0], space, board_state)
            return true
          elsif space == move[1][1] && !is_white
            return false unless landing_piece_is_white?(@is_white, move[0][0], space, board_state)
            return true
          end
          return false unless board_state[convert_number_to_position([move[0][0], space]).to_sym].nil?
        end
      elsif move[0][1] > move[1][1]
        start = move[0][1] - 1
        start.downto(move[1][1]) do |space|
          if space == move[1][1] && is_white
            return false if landing_piece_is_white?(@is_white, move[0][0], space, board_state)
            return true
          elsif space == move[1][1] && !is_white
            return false unless landing_piece_is_white?(@is_white, move[0][0], space, board_state)
            return true
          end
          return false unless board_state[convert_number_to_position([move[0][0], space]).to_sym].nil?
        end
      end
    elsif move[0][1] == move[1][1]
      if move[0][0] < move[1][0]
        start = move[0][0] + 1
        start.upto(move[1][0]) do |space|
          if space == move[1][0] && is_white
            return false if landing_piece_is_white?(@is_white, space, move[0][1], board_state)
            return true
          elsif space == move[1][0] && !is_white
            return false unless landing_piece_is_white?(@is_white, space, move[0][1], board_state)
            return true
          end
          return false unless board_state[convert_number_to_position([space, move[0][1]]).to_sym].nil?
        end
      elsif move[0][0] > move[1][0]
        start = move[0][0] - 1
        start.downto(move[1][0]) do |space|
          if space == move[1][0] && is_white
            return false if landing_piece_is_white?(@is_white, space, move[0][1], board_state)
            return true
          elsif space == move[1][0] && !is_white
            return false unless landing_piece_is_white?(@is_white, space, move[0][1], board_state)
            return true
          end
          return false unless board_state[convert_number_to_position([space, move[0][1]]).to_sym].nil?
        end
      end
    end
  end

  def diagonal_path_clear?(move, board_state)
    if move[0][0] > move[1][0] && move[0][1] > move[1][1]
      start = move[0][0] - 1
      y_pos = move[0][1] - 1
      start.downto(move[1][0]) do |space|
        if [space, y_pos] == move[1] && is_white
          return false if landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        elsif [space, y_pos] == move[1] && !is_white
          return false unless landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        end
        return false unless board_state[convert_number_to_position([space, y_pos]).to_sym].nil?
        y_pos -= 1
      end
    elsif move[0][0] < move[1][0] && move[0][1] < move[1][1]
      start = move[0][0] + 1
      y_pos = move[0][1] + 1
      start.upto(move[1][0]) do |space|
        if [space, y_pos] == move[1] && is_white
          return false if landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        elsif [space, y_pos] == move[1] && !is_white
          return false unless landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        end
        return false unless board_state[convert_number_to_position([space, y_pos]).to_sym].nil?
        y_pos += 1
      end
    elsif move[0][0] < move[1][0] && move[0][1] > move[1][1]
      start = move[0][0] + 1
      y_pos = move[0][1] - 1
      start.upto(move[1][0]) do |space|
        if [space, y_pos] == move[1] && is_white
          return false if landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        elsif [space, y_pos] == move[1] && !is_white
          return false unless landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        end
        return false unless board_state[convert_number_to_position([space, y_pos]).to_sym].nil?
        y_pos -= 1
      end
    elsif move[0][0] > move[1][0] && move[0][1] < move[1][1]
      start = move[0][0] - 1
      y_pos = move[0][1] + 1
      start.downto(move[1][0]) do |space|
        if [space, y_pos] == move[1] && is_white
          return false if landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        elsif [space, y_pos] == move[1] && !is_white
          return false unless landing_piece_is_white?(@is_white, space, y_pos, board_state)
          return true
        end
        return false unless board_state[convert_number_to_position([space, y_pos]).to_sym].nil?
        y_pos += 1
      end
    end
  end
end
