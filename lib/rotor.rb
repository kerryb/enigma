class Rotor
  def initialize mapping, turnover_position
    @mapping = mapping
    @turnover_position = turnover_position
    @ring_offset = 0
    @position = 0
    calculate_mappings
  end

  def turnover?
    current_letter == @turnover_position
  end

  def ring_setting= setting
    @ring_offset = setting - 1
    calculate_mappings
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

  def calculate_mappings
    @leftward_mapping = offset(ALPHABET).zip(offset(@mapping.chars)).to_h
    @rightward_mapping = @leftward_mapping.invert
  end

  def offset chars
    chars.map {|char| ALPHABET[(ALPHABET.index(char) + @ring_offset) % 26] }
  end

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
