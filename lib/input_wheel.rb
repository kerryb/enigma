class InputWheel
  def initialize mapping
    @mapping = mapping
  end

  def translate_left letter
    @mapping.index letter
  end

  def translate_right position
    @mapping[position]
  end
end
