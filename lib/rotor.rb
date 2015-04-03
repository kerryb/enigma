class Rotor
  def initialize mapping, turnover_position
    @leftward_mapping = ALPHABET.zip(mapping.chars).to_h
    @rightward_mapping = @leftward_mapping.invert
    @turnover_position = turnover_position
    @position = 0
  end

  def turnover?
    current_letter == @turnover_position
  end

  def position= letter
    @position = ALPHABET.index letter
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

  def current_letter
    letter_in_position 0
  end
end
