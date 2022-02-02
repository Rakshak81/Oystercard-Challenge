require_relative '../lib/station'
describe Station do
  describe '# name' do
    it "It should have a Name" do
      station = Station.new("Oxford")

      expect(station.name).to eq("Oxford")
    end
  end
end