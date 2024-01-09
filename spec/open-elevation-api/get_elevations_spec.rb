require 'spec_helper'

RSpec.describe OpenElevationApi::GetElevations do
  it 'returns error if longitude or latitude missing' do
      elevation_stuct = OpenStruct.new(longitude: 21.01, elevation: nil)

      service = described_class.new(collection: [elevation_stuct])
      expect{service.call}.to raise_error OpenElevationApi::InvalidCollection
  end

  it 'gets single elevation - and enhancing collection' do
    VCR.use_cassette('single location') do
      elevation_stuct = OpenStruct.new(longitude: 21.01, latitude: 51.01, elevation: nil)

      service = described_class.new(collection: [elevation_stuct])
      service.call

      expect(service.raw_response).to eq [{ 'latitude' => 51.01, 'longitude' => 21.01, 'elevation' => 290.0 }]
      expect(service.collection_with_result.first.elevation).to eq 290.0
    end
  end

  it 'gets single elevation - and enhancing collection, but with different method names' do
    VCR.use_cassette('single location') do
      elevation_stuct = OpenStruct.new(lon: 21.01, lat: 51.01, elevation: nil)

      service = described_class.new(collection: [elevation_stuct], longitude_method: :lon, latitude_method: :lat)
      service.call

      expect(service.raw_response).to eq [{ 'latitude' => 51.01, 'longitude' => 21.01, 'elevation' => 290.0 }]
      expect(service.collection_with_result.first.elevation).to eq 290.0
      expect(service.collection_with_result.first.lat).to eq 51.01
    end
  end

  it 'gets single elevation - and enhancing collection' do
    VCR.use_cassette('single location') do
      ElevationImmutableStruct = Struct.new(:longitude, :latitude)
      elevation_stuct = ElevationImmutableStruct.new(21.01, 51.01)

      collection = [elevation_stuct]
      service = described_class.new(collection:)
      service.call

      expect(service.raw_response).to eq [{ 'latitude' => 51.01, 'longitude' => 21.01, 'elevation' => 290.0 }]
      expect(service.collection_with_result).to eq collection
    end
  end

  it 'gets multiple elevation - and enhancing collection' do
    VCR.use_cassette('multiple location') do
      elevation_stuct = OpenStruct.new(longitude: 21.01, latitude: 51.01, elevation: nil)
      elevation_stuct_2 = OpenStruct.new(longitude: 21.06, latitude: 51.21, elevation: nil)
      elevation_stuct_3 = OpenStruct.new(longitude: 20.91, latitude: 51.51, elevation: nil)

      service = described_class.new(collection: [elevation_stuct, elevation_stuct_2, elevation_stuct_3])
      service.call

      expect(service.raw_response.map{|r| r['elevation']}).to eq [290.0, 193.0, 162.0]
      expect(service.collection_with_result.first.elevation).to eq 290.0
      expect(service.collection_with_result.last.elevation).to eq 162.0
    end
  end
end
