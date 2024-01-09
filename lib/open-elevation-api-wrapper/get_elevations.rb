module OpenElevationApi
  class GetElevations
    attr_reader :raw_response, :collection_with_result

    def initialize(collection:, longitude_method: :longitude, latitude_method: :latitude)
      @collection = collection
      @longitude_method = longitude_method
      @latitude_method = latitude_method
    end

    def call
      raise InvalidCollection.new('Latitude or Longitude not provided') unless verify_collection
      @raw_response = api_result
      @collection_with_result = combined_results
    end

    private

    def verify_collection
      @collection.all?{|obj| obj.respons_to?(@longitude_method) && obj.respons_to?(@latitude_method)}
    end

    def body
      {
        locations: @collection.map do |obj|
          { latitude: obj.send(@latitude_method), longitude: obj.send(@longitude_method) }
        end
      }.to_json
    end

    def api_result
      @api_result ||= HTTParty.post(
        OpenElevationApi.configuration.api_url,
        body:,
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'}
      )['results']
    end

    def combine_results
      @collection.each do |robj|
        result = api_result.find do |res| 
          res[:latitude] == obj.send(@latitude_method) && res[:longitude] == obj.send(@longitude_method)
        end

        next unless result
        @collection.elevation = result[:elevation]
      end
    end
  end
end
