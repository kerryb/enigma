require "machine"

describe Machine do
  let(:left_rotor) { spy :left_rotor, rollover?: false }
  let(:middle_rotor) { spy :middle_rotor, rollover?: false }
  let(:right_rotor) { spy :right_rotor, rollover?: false }
  subject { described_class.new rotors: [right_rotor, middle_rotor, left_rotor] }

  describe "#type" do
    it "advances the first rotor" do
      subject.type "A"
      expect(right_rotor).to have_received :advance
    end

    it "advances other rotors if adjacent to a rollover notch" do
      allow(right_rotor).to receive(:rollover?) { true }
      subject.type "A"
      expect(middle_rotor).to have_received :advance
    end

    it "does not advance other rotors if not adjacent to a rollover notch" do
      allow(right_rotor).to receive(:rollover?) { false }
      subject.type "A"
      expect(middle_rotor).not_to have_received :advance
    end

    it "advances the notched rotor along with the one to its left" do
      allow(middle_rotor).to receive(:rollover?) { true }
      subject.type "A"
      expect(middle_rotor).to have_received :advance
    end

    it "only advances the right rotor once, even when rolling over the middle one" do
      allow(right_rotor).to receive(:rollover?) { true }
      subject.type "A"
      expect(right_rotor).to have_received(:advance).once
    end
  end
end
