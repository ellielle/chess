class String
  def white
    "\e[37m#{self}\e[0m"
  end

  def black
    "\e[35m#{self}\e[0m"
  end

  def prev!
    self[0] = (self.ord - 1).chr
  end
end
