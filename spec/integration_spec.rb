require "machine"
require "rotor"
require "reflector"

describe "Integration" do
  let(:rotor_1) { Rotor.new "EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q" }
  let(:rotor_2) { Rotor.new "AJDKSIRUXBLHWTMCQGZNPYFVOE", "E" }
  let(:rotor_3) { Rotor.new "BDFHJLCPRTXVZNYEIWGAKMUSQO", "V" }
  let(:reflector) { Reflector.new "YRUHQSLDPXNGOKMIEBFZCWVJAT" }

  def encrypt plaintext
    plaintext.chars.map {|c| machine.encrypt c }.join
  end

  context "using rotors I, II, III in home positions" do
    subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector }

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "MFNCZBBFZM"
    end
  end

  context "using rotors in a different order" do
    subject(:machine) { Machine.new rotors: [rotor_2, rotor_3, rotor_1], reflector: reflector }

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "ZXVMIZYFEY"
    end
  end
end
