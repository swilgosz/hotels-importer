# frozen_string_literal: true

require 'dry/transformer/all'
require 'managing_hotels/importing/paperfiles/functions'

module ManagingHotels
  module Importing
    module Paperfiles
      class Transformation < Dry::Transformer::Pipe
        import Dry::Transformer::ArrayTransformations
        import Dry::Transformer::HashTransformations

        define! do
          map_array do
            map_keys(Functions[:underscore])
            deep_symbolize_keys
            map_values(Functions[:strip])
            rename_keys(
              hotel_id: :external_id,
              hotel_name: :name,
              details: :description,
            )
            map_value(:location) do
              map_value(:address, Functions[:extract_zip])
              unwrap(:address, [:address, :zip])
            end
            map_value(:amenities, Functions[:flatten])
            map_value(:amenities) do
              map_array(Functions[:parameterize])
              map_array(Functions[:underscore])
              map_array(Functions[:strip])
            end
            map_value(:images, Functions[:flatten])
            map_value(:images) do
              map_array do
                rename_keys(link: :url, caption: :description)
              end
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
