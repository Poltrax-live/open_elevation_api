# frozen_string_literal: true

require 'pry'
require 'date'
require 'active_support'
require 'active_support/time_with_zone'
require 'active_support/core_ext/time/zones'

require File.expand_path('open-elevation-api/get_elevations.rb', __dir__)
require File.expand_path('open-elevation-api/configuration.rb', __dir__)

module OpenElevationApi
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
