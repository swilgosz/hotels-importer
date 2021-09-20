# frozen_string_literal: true

require 'api/v1/endpoints/hotels/serializer'

module Api
  module V1
    module Endpoints
      module Hotels
        class Index
          def call(params)
            filters = filter_params(params)
            Rails.cache.fetch(cache_key(filters), expires_in: 12.hours) do
              scope = Hotel.all

              scope = scope.by_destination(filters[:destination]) if filters.key?(:destination)
              scope = scope.by_ids(filters[:hotels]) if filters.key?(:hotels)
              serializer.call(scope.to_a.map(&:as_json))
            end
          end

          private

          def filter_params(params)
            params.permit(:destination, hotels: [])
          end

          def cache_key(filters)
            ['api', 'v1', 'hotels', filters[:destination], filters[:hotels]].join
          end

          def serializer
            Serializer.new
          end
        end
      end
    end
  end
end
