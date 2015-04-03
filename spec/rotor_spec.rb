require "rotor"

describe Rotor do
  subject { described_class.new "EKMFLGDQVZNTOWYHXUSPAIBRCJ", ["Q"] }

  describe "#turnover?" do
    it "is true when the current position aligns with a turnover notch"

    it "is false otherwise"
  end

  describe "#translate_left" do
    it "returns the left contact mapped to the supplied right contact" do
      expect(subject.translate_left 0).to eq 4 # 0 => A => E => 4
      expect(subject.translate_left 25).to eq 9 # 25 => Z => J => 9
    end

    it "adjusts for rotation of the rotor" do
      subject.advance
      expect(subject.translate_left 0).to eq 9 # 0 => B => K => 11
      expect(subject.translate_left 25).to eq 3 # 25 => A => E => 3
    end

    it "returns to its initial position after a full rotation" do
      26.times { subject.advance }
      expect(subject.translate_left 0).to eq 4 # 0 => A => E => 4
    end
  end
end
