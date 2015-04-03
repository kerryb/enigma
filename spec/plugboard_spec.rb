require "plugboard"

describe Plugboard do
  it "translates letters to themselves by default" do
    expect(subject.translate "A").to eq "A"
  end

  it "swaps pairs of letters when they have benpatched together" do
    subject.patch "A", "Z"
    expect(subject.translate "A").to eq "Z"
  end
end
