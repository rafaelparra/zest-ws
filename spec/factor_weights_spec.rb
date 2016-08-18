require './lib/factor_weights'
require 'pry'

describe FactorWeights do

  describe "find" do

    it "when using a valid id" do
      factor2 = FactorWeights.find(2)
      expect(factor2.chloroform_weight).to eq(1.0)
      expect(factor2.bromoform_weight).to eq(1.0)
      expect(factor2.bromodichloromethane_weight).to eq(1.0)
      expect(factor2.dibromichloromethane_weight).to eq(1.0)
    end

    it "when using un-existing ids" do
      sample = FactorWeights.find(5)
      expect(sample).to be_nil
    end

    it "when using string ids" do
      sample = FactorWeights.find("cinco")
      expect(sample).to be_nil
    end

  end

  describe "all_ids" do
    it { expect(FactorWeights.all_ids).to eq([1,2,3,4])}
  end
  
end