# frozen_string_literal: true

require 'dry/transformer/all'
require 'managing_hotels/importing/patagonia/functions'
module ManagingHotels
  module Importing
    module Patagonia
      class Transformation < Dry::Transformer::Pipe
        import Dry::Transformer::ArrayTransformations
        import Dry::Transformer::HashTransformations

        define! do
          map_array do
            deep_symbolize_keys
            rename_keys(
              id: :external_id,
              destination: :destination_id,
              info: :description
            )
            map_value(:address, Functions[:extract_zip])
            unwrap(:address, [:address, :zip])
            map_values(Functions[:strip])
            nest :location, [:lat, :lng, :zip, :address]
            map_value(:amenities) do
              map_array(Functions[:parameterize])
              map_array(Functions[:underscore])
              map_array(Functions[:strip])
            end
            map_value(:images, Functions[:flatten])
          end
        end

        def connection
          @connection ||= ManagingHotels::Importing::Connection.new
        end
      end
    end
  end
end
