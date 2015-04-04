require "machine"
require "input_wheel"
require "plugboard"
require "rotor"
require "reflector"

describe "Integration" do
  subject(:machine) {
    Machine.new(
      plugboard: plugboard,
      input_wheel: input_wheel,
      rotors: rotors,
      reflector: reflector,
    )
  }
  let(:plugboard) { Plugboard.new }
  let(:input_wheel) { InputWheel.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
  let(:rotor_1) { Rotor.new "EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q" }
  let(:rotor_2) { Rotor.new "AJDKSIRUXBLHWTMCQGZNPYFVOE", "E" }
  let(:rotor_3) { Rotor.new "BDFHJLCPRTXVZNYEIWGAKMUSQO", "V" }
  let(:rotors) { [rotor_1, rotor_2, rotor_3] }
  let(:reflector) { Reflector.new "YRUHQSLDPXNGOKMIEBFZCWVJAT" }

  def encrypt plaintext
    plaintext.chars.map {|c| machine.encrypt c }.join
  end

  context "using rotors I, II, III in home positions" do
    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "MFNCZBBFZM"
    end
  end

  context "using rotors in a different order" do
    let(:rotors) { [rotor_2, rotor_3, rotor_1] }

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "ZXVMIZYFEY"
    end
  end

  context "with patch cables on the plugboard" do
    before do
      plugboard.patch "C", "Q"
      plugboard.patch "X", "P"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "MFNQZBBFZM"
    end
  end

  context "using rotors set to different initial positions" do
    before do
      rotor_1.position = "B"
      rotor_2.position = "X"
      rotor_3.position = "J"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "QNDMFRCGTS"
    end
  end

  context "using rotors with different ring settings" do
    before do
      rotor_1.ring_setting = 5
      rotor_2.ring_setting = 13
      rotor_3.ring_setting = 20
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "JCEESPSDYR"
    end
  end

  context "with turnover of middle and left wheels" do
    before do
      rotor_1.position = "P"
      rotor_2.position = "E"
    end

    it "encrypts correctly" do
      expect(encrypt "HELLOWORLD").to eq "SBYPKYUPVB"
    end
  end
end
