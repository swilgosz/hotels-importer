# frozen_string_literal: true

require 'dry/transformer/all'
module Api
  module V1
    module Endpoints
      module Hotels
        class Serializer < Dry::Transformer::Pipe
          import Dry::Transformer::ArrayTransformations
          import Dry::Transformer::HashTransformations

          define! do
            map_array do
              deep_symbolize_keys
              reject_keys [:id]
              rename_keys external_id: :id
            end
          end
        end
      end
    end
  end
end
