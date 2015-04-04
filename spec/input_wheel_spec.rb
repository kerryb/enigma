require "input_wheel"

describe InputWheel do
  subject { described_class.new "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }

  describe "#translate_left" do
    it "returns the number of the position corresponding to the supplied letter" do
      expect(subject.translate_left "E").to eq 4
    end
  end

  describe "#translate_right" do
    it "returns the letter corresponding to the supplied position" do
      expect(subject.translate_right 25).to eq "Z"
    end
  end
end
