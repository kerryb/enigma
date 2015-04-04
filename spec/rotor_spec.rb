require "rotor"

describe Rotor do
  subject { described_class.new(
    #ABCDEFGHIJKLMNOPQRSTUVWXYZ
    "EKMFLGDQVZNTOWYHXUSPAIBRCJ", "Q"
  )}

  describe "#turnover?" do
    it "is normally false" do
      expect(subject).not_to be_turnover
    end

    it "is true when in the turnover position" do
      subject.position = "Q"
      expect(subject).to be_turnover
    end
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

    it "adjusts for ring setting" do
      subject.ring_setting = 2 # default is 1
      expect(subject.translate_left 0).to eq 10 # 0 => A => K => 10
      expect(subject.translate_left 25).to eq 3 # 25 => Z => D => 3
    end

    it "returns to its initial position after a full rotation" do
      26.times { subject.advance }
      expect(subject.translate_left 0).to eq 4 # 0 => A => E => 4
    end
  end

  describe "#translate_right" do
    it "returns the right contact mapped to the supplied right contact" do
      expect(subject.translate_right 0).to eq 20 # 0 => A => U => 21
      expect(subject.translate_right 25).to eq 9 # 25 => Z => J => 9
    end

    it "adjusts for rotation of the rotor" do
      subject.advance
      expect(subject.translate_right 0).to eq 21 # 0 => B => W => 21
      expect(subject.translate_right 25).to eq 19 # 25 => A => U => 19
    end

    it "returns to its initial position after a full rotation" do
      26.times { subject.advance }
      expect(subject.translate_right 0).to eq 20 # 0 => A => U => 21
    end
  end
end
