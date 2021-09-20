# frozen_string_literal: true

require 'net/http'
require 'json'

module ManagingHotels
  module Importing
    class Connection
      def call(url)
        uri = URI(url)
        res = Net::HTTP.get(uri) # => String
        JSON.parse(res || '[]')
      end
    end
  end
end
