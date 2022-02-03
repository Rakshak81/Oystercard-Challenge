require_relative '../lib/station'
describe Station do
  subject(:station) {described_class.new("Oxford", 1 )}

  describe '# name' do
    it "It should have a Name" do
      
      expect(station.name).to eq("Oxford")
    end
  end

    it "It should have a Zone" do
  

      expect(station.zone).to eq(1)
    end
  
end