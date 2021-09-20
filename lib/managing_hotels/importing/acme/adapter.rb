# frozen_string_literal: true

require 'managing_hotels/importing/connection'
require 'managing_hotels/importing/acme/schema'
require 'managing_hotels/importing/acme/transformation'

module ManagingHotels
  module Importing
    module Acme
      class Adapter
        URL = 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'

        def call
          input = connection.call(URL)
          validated = validate(input)
          transformation.call(validated)
        end

        private

        attr_reader :connection, :transformation

        def initialize
          @connection = Connection.new
          @transformation = Transformation.new
        end

        def validate(input)
          (input || []).each do |item|
            res = Schema.call(item)
            next if res.errors.present?
          end.compact
        end
      end
    end
  end
end
