module ConvertCoordinates
  def convert_position_to_number(move)
    hsh = { a: "1", b: "2", c: "3", d: "4", e: "5", f: "6", g: "7", h: "8" }
    position = hsh[move[0].to_sym] + move[1]
    return position.split(//).map { |chr| chr.to_i }
  end

  def convert_number_to_position(move)
    hsh = { "1": "a", "2": "b", "3": "c", "4": "d", "5": "e", "6": "f", "7": "g", "8": "h" }
    position = hsh[move[0].to_s.to_sym] + move[1].to_s
  end
end
