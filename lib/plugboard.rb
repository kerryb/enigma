class Plugboard
  def initialize
    @patches = {}
  end

  def patch letter_1, letter_2
    @patches[letter_1] = letter_2
    @patches[letter_2] = letter_1
  end

  def translate letter
    @patches.fetch(letter) { letter }
  end
end
