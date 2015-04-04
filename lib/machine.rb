class Machine
  def initialize input_wheel:, plugboard:, rotors:, reflector:
    @input_wheel = input_wheel
    @plugboard = plugboard
    @rotors = rotors
    @reflector = reflector
  end

  def encrypt letter
    rotors_to_advance.each(&:advance)
    input_position = @input_wheel.translate_left @plugboard.translate(letter)
    reflector_input = @rotors.reduce(input_position) {|position, rotor| rotor.translate_left position }
    reflector_output = @reflector.translate reflector_input
    output_position = @rotors.reverse.reduce(reflector_output) {|position, rotor| rotor.translate_right position }
    @plugboard.translate @input_wheel.translate_right(output_position)
  end

  private

  ALPHABET = (?A..?Z).to_a

  def rotors_to_advance
    ([@rotors.first] + @rotors.each_cons(2).select {|right, left| right.turnover? }.flatten).uniq
  end
end
