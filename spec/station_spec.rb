require 'station'

describe Station do
  context "#Richmond" do
    let(:station) {Station.new("Richmond", 4)}
    it "returns the name of the station" do
      expect(station.name).to eq "Richmond"
    end

    it "returns the zone that the station is in" do
      expect(station.zone).to eq 4
    end
  end
end
