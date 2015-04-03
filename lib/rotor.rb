class Rotor
  def initialize mapping, turnover_positions
    @leftward_mapping = ALPHABET.zip(mapping.chars).to_h
    @rightward_mapping = @leftward_mapping.invert
    @position = 0
  end

  def turnover?
  end

  def advance
    @position = (@position + 1) % 26
  end

  def translate_left contact
    letter = @leftward_mapping.fetch letter_in_position(contact)
    position_of_letter letter
  end

  def translate_right contact
    letter = @rightward_mapping.fetch letter_in_position(contact)
    position_of_letter letter
  end

  private

  ALPHABET = (?A..?Z).to_a

  def letter_in_position position
    ALPHABET[(@position + position) % 26]
  end

  def position_of_letter letter
    ALPHABET.rotate(@position).index letter
  end
end
