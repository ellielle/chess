class String
  def white_background
    "\e[47m#{self}\e[0m"
  end
end