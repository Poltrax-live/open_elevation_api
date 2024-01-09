# frozen_string_literal: true

module OpenElevationApi
  class Configuration
    attr_accessor :api_url

    OPEN_ELEAVATION_API_URL = 'https://api.open-elevation.com/api/v1/lookup'.freeze

    def initialize(api_url = nil)
      @api_url = api_url || OPEN_ELEAVATION_API_URL
    end
  end
end
