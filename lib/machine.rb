class Machine
  def initialize rotors:, reflector:
    @rotors = rotors
    @reflector = reflector
  end

  def encrypt letter
    rotors_to_advance.each(&:advance)
    letters = (?A..?Z).to_a
    input_position = letters.index(letter)
    reflector_input = @rotors.reduce(input_position) {|position, rotor| rotor.translate_left position }
    reflector_output = @reflector.map reflector_input
    output_position = @rotors.reverse.reduce(reflector_output) {|position, rotor| rotor.translate_right position }
    letters[output_position]
  end

  private

  def rotors_to_advance
    ([@rotors.first] + @rotors.each_cons(2).select {|right, left| right.turnover? }.flatten).uniq
  end
end
