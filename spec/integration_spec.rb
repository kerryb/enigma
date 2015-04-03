require "machine"
require "plugboard"
require "rotor"
require "reflector"

describe "Integration" do
  let(:plugboard) { Plugboard.new }
  let(:rotor_1) { Rotor.new "EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q" }
  let(:rotor_2) { Rotor.new "AJDKSIRUXBLHWTMCQGZNPYFVOE", "E" }
  let(:rotor_3) { Rotor.new "BDFHJLCPRTXVZNYEIWGAKMUSQO", "V" }
  let(:reflector) { Reflector.new "YRUHQSLDPXNGOKMIEBFZCWVJAT" }

  def encrypt plaintext
    plaintext.chars.map {|c| machine.encrypt c }.join
  end

  context "using rotors I, II, III in home positions" do
    subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector, plugboard: plugboard }

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "MFNCZBBFZM"
    end
  end

  context "using rotors in a different order" do
    subject(:machine) { Machine.new rotors: [rotor_2, rotor_3, rotor_1], reflector: reflector, plugboard: plugboard }

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "ZXVMIZYFEY"
    end
  end

  context "with patch cables on the plugboard" do
    subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector, plugboard: plugboard }

    before do
      plugboard.patch "C", "Q"
      plugboard.patch "X", "P"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "MFNQZBBFZM"
    end
  end

  context "using rotors set to different initial positions" do
    subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector, plugboard: plugboard }

    before do
      rotor_1.position = "B"
      rotor_2.position = "X"
      rotor_3.position = "J"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "QNDMFRCGTS"
    end
  end

  context "with turnover of middle and left wheels" do
    subject(:machine) { Machine.new rotors: [rotor_1, rotor_2, rotor_3], reflector: reflector, plugboard: plugboard }

    before do
      rotor_1.position = "P"
      rotor_2.position = "E"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "SBYPKYUPVB"
    end
  end
end
