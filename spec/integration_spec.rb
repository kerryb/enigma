require "machine"
require "rotor"
require "reflector"

describe "Integration" do
  subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector }
  let(:rotor_1) { Rotor.new "EKMFLGDQVZNTOWYHXUSPAIBRCJ", ["Q"] }
  let(:rotor_2) { Rotor.new "AJDKSIRUXBLHWTMCQGZNPYFVOE", ["E"] }
  let(:rotor_3) { Rotor.new "BDFHJLCPRTXVZNYEIWGAKMUSQO", ["V"] }
  let(:reflector) { Reflector.new "QYHOGNECVPUZTFDJAXWMKISRBL" }

  def encrypt plaintext
    plaintext.chars.map {|c| machine.encrypt c }.join
  end

  it "encrypts correctly using wheels I, II, III in home positions" do
    expect(encrypt "HELLOWORLD").to eq "MFNCZBBFZM"
  end
end
