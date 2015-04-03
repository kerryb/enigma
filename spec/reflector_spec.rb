require "reflector"

describe Reflector do
  subject { described_class.new(
    #ABCDEFGHIJKLMNOPQRSTUVWXYZ
    "YRUHQSLDPXNGOKMIEBFZCWVJAT"
  )}


  describe "#translate" do
    it "returns the contact mapped to the supplied contact" do
      expect(subject.translate 0).to eq 24 # 0 => A => Y => 24
    end
  end
end
