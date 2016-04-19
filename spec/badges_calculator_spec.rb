require File.expand_path('../../lib/badges_calculator', __FILE__)

describe BadgesCalculator do
  it "calculates the correct price" do
    expect(subject.calculate_price(0)).to eq("0.0")
    expect(subject.calculate_price(1)).to eq("3.0")
    expect(subject.calculate_price(11)).to eq("10.85")
    expect(subject.calculate_price(5001)).to eq("1622.82")
  end
end