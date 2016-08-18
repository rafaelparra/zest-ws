require './lib/water_sample'
require 'pry'

describe WaterSample do

  let(:sample2) { WaterSample.find(2) }

  describe "find" do

    it "when using a valid id" do
      expect(sample2.site).to eq("North Hollywood Pump Station (well blend)")
      expect(sample2.chloroform).to eq(0.00291)
      expect(sample2.bromoform).to eq(0.00487)
      expect(sample2.bromodichloromethane).to eq(0.00547)
      expect(sample2.dibromichloromethane).to eq(0.0109)
    end

    it "when using un-existing ids" do
      sample = WaterSample.find(5)
      expect(sample).to be_nil
    end

    it "when using string ids" do
      sample = WaterSample.find("cinco")
      expect(sample).to be_nil
    end

  end

  describe "factor" do
    it { expect(sample2.factor(1)).to eq(0.024007) }
    it { expect(sample2.factor(2)).to eq(0.02415) }
    it { expect(sample2.factor(3)).to eq(0.021627) }
    it { expect(sample2.factor(4)).to eq(0.02887) }
    it { expect(sample2.factor(5)).to be_nil }
    it { expect(sample2.factor("six")).to be_nil }
  end

  describe "to_hash" do
    it "when include_factors is false" do
      expect(sample2.to_hash).to eq({ :id=>2, 
                                      :site=>"North Hollywood Pump Station (well blend)", 
                                      :chloroform=>0.00291, 
                                      :bromoform=>0.00487, 
                                      :bromodichloromethane=>0.00547, 
                                      :dibromichloromethane=>0.0109})
    end
    it "when include_factors is true" do
      expect(sample2.to_hash(true)).to eq({:id=>2,
                                           :site=>"North Hollywood Pump Station (well blend)",
                                           :chloroform=>0.00291,
                                           :bromoform=>0.00487,
                                           :bromodichloromethane=>0.00547,
                                           :dibromichloromethane=>0.0109,
                                           :factor_1=>0.024007,
                                           :factor_2=>0.02415,
                                           :factor_3=>0.021627,
                                           :factor_4=>0.02887})
    end
  end

end