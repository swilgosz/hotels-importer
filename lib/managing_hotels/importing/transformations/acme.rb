# frozen_string_literal: true

require 'dry/transformer/all'
require 'managing_hotels/importing/transformations/functions'

module ManagingHotels
  module Importing
    module Transformations
      class Acme < Dry::Transformer::Pipe
        import Dry::Transformer::ArrayTransformations
        import Dry::Transformer::HashTransformations

        define! do
          map_array do
            map_keys(Functions[:underscore])
            deep_symbolize_keys
            rename_keys(
              id: :external_id,
              latitude: :lat,
              longitude: :lng,
              postal_code: :zip,
              facilities: :amenities
            )
            map_values(Functions[:strip])
            nest :location, [:lat, :lng, :zip, :address, :city, :country]
            # binding.irb
            map_value(:amenities) do
              map_array(Functions[:underscore])
              map_array(Functions[:strip])
            end
          end
        end

        def connection
          @connection ||= ManagingHotels::Importing::Connection.new
        end
      end
    end
  end
end
