# frozen_string_literal: true

require 'managing_hotels/importing/connection'
require 'managing_hotels/importing/paperflies/transformation'

module ManagingHotels
  module Importing
    module Paperflies
      class Adapter
        URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies'

        def call
          input = connection.call(URL)
          transformation.call(input)
        end

        private

        attr_reader :connection, :transformation

        def initialize
          @connection = Connection.new
          @transformation = Transformation.new
        end
      end
    end
  end
end
