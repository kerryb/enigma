require "machine"

describe Machine do
  let(:input_wheel) { double(:input_wheel).as_null_object }
  let(:plugboard) { double(:plugboard).as_null_object }
  let(:left_rotor) { spy :left_rotor, turnover?: false }
  let(:middle_rotor) { spy :middle_rotor, turnover?: false }
  let(:right_rotor) { spy :right_rotor, turnover?: false }
  let(:reflector) { spy :reflector }
  subject {
    described_class.new(
      input_wheel: input_wheel,
      plugboard: plugboard,
      rotors: [right_rotor, middle_rotor, left_rotor],
      reflector: reflector
    )
  }

  describe "#encrypt" do
    it "advances the first rotor" do
      subject.encrypt "A"
      expect(right_rotor).to have_received :advance
    end

    it "advances other rotors if adjacent to a turnover notch" do
      allow(right_rotor).to receive(:turnover?) { true }
      subject.encrypt "A"
      expect(middle_rotor).to have_received :advance
    end

    it "does not advance other rotors if not adjacent to a turnover notch" do
      allow(right_rotor).to receive(:turnover?) { false }
      subject.encrypt "A"
      expect(middle_rotor).not_to have_received :advance
    end

    it "advances the notched rotor along with the one to its left" do
      allow(middle_rotor).to receive(:turnover?) { true }
      subject.encrypt "A"
      expect(middle_rotor).to have_received :advance
    end

    it "only advances the right rotor once, even when rolling over the middle one" do
      allow(right_rotor).to receive(:turnover?) { true }
      subject.encrypt "A"
      expect(right_rotor).to have_received(:advance).once
    end

    it "sends the signal through the plugboard, input wheel and rotors to the reflector and back" do
      allow(plugboard).to receive(:translate).with("A") { "B" }
      allow(input_wheel).to receive(:translate_left).with("B") { 1 }
      allow(right_rotor).to receive(:translate_left).with(1) { 2 }
      allow(middle_rotor).to receive(:translate_left).with(2) { 3 }
      allow(left_rotor).to receive(:translate_left).with(3) { 4 }
      allow(reflector).to receive(:translate).with(4) { 5 }
      allow(left_rotor).to receive(:translate_right).with(5) { 6 }
      allow(middle_rotor).to receive(:translate_right).with(6) { 7 }
      allow(right_rotor).to receive(:translate_right).with(7) { 8 }
      allow(input_wheel).to receive(:translate_right).with(8) { "H" }
      allow(plugboard).to receive(:translate).with("H") { "I" }
      expect(subject.encrypt "A").to eq "I"
    end
  end
end
