class Reflector
  def initialize mapping
    @mapping = ALPHABET.zip(mapping.chars).to_h
  end

  def translate contact
    letter = @mapping.fetch letter_in_position(contact)
    position_of_letter letter
  end

  private

  ALPHABET = (?A..?Z).to_a

  def letter_in_position position
    ALPHABET[position]
  end

  def position_of_letter letter
    ALPHABET.index letter
  end
end
