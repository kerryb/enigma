class Machine
  def initialize rotors:
    @rotors = rotors
  end

  def type letter
    rotors_to_advance.each(&:advance)
  end

  private

  def rotors_to_advance
    ([@rotors.first] + @rotors.each_cons(2).select {|right, left| right.rollover? }.flatten).uniq
  end
end
