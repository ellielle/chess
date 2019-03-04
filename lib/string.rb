class String
  def prev!
    self[0] = (self.ord - 1).chr
  end
end