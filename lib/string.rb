class String
  def white_background
    "\e[47m#{self}\e[0m"
  end

  def prev!
    self[0] = (self.ord - 1).chr
  end
end