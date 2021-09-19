# frozen_string_literal: true

require 'dry/transformer/all'
require 'managing_hotels/importing/transformations/functions'

module ManagingHotels
  module Importing
    module Transformations
      class PatagoniaInflector < Inflector
        def extract_zip(str)
          elements = str.split(',')
          zip = elements.pop.strip
          address = elements.join(',')
          { address: address, zip: zip }
        end

        def flatten(h)
          h.each_with_object([]) do |(k, v), obj|
            v.each { |val| obj.push(val) }
          end.uniq
        end

        def parameterize(str)
          dasherize(str).gsub(/\s/, '-')
        end
      end

      module PatagoniaFunctions
        extend Dry::Transformer::Registry
        extend Functions

        inflector = PatagoniaInflector.new
        import :extract_zip, from: inflector
        import :flatten, from: inflector
        import :parameterize, from: inflector
      end

      class Patagonia < Dry::Transformer::Pipe
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
            map_value(:address, PatagoniaFunctions[:extract_zip])
            unwrap(:address, [:address, :zip])
            map_values(Functions[:strip])
            nest :location, [:lat, :lng, :zip, :address]
            map_value(:amenities) do
              map_array(PatagoniaFunctions[:parameterize])
              map_array(Functions[:underscore])
              map_array(Functions[:strip])
            end
            map_value(:images, PatagoniaFunctions[:flatten])
          end
        end

        def connection
          @connection ||= ManagingHotels::Importing::Connection.new
        end
      end
    end
  end
end
