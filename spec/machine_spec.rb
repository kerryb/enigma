require "machine"

describe Machine do
  let(:left_rotor) { spy :left_rotor, turnover?: false }
  let(:middle_rotor) { spy :middle_rotor, turnover?: false }
  let(:right_rotor) { spy :right_rotor, turnover?: false }
  let(:reflector) { spy :reflector }
  subject { described_class.new rotors: [right_rotor, middle_rotor, left_rotor], reflector: reflector }

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

    it "sends the signal through the rotors to the reflector and back" do
      allow(right_rotor).to receive(:translate_left).with(0) { 1 }
      allow(middle_rotor).to receive(:translate_left).with(1) { 2 }
      allow(left_rotor).to receive(:translate_left).with(2) { 3 }
      allow(reflector).to receive(:translate).with(3) { 4 }
      allow(left_rotor).to receive(:translate_right).with(4) { 5 }
      allow(middle_rotor).to receive(:translate_right).with(5) { 6 }
      allow(right_rotor).to receive(:translate_right).with(6) { 7 }
      expect(subject.encrypt "A").to eq "H"
    end
  end
end
