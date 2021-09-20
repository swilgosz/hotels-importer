# frozen_string_literal: true

require 'dry-schema'

module ManagingHotels
  module Importing
    module Patagonia
      Schema = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:destination).filled(:integer)
        required(:name).filled(:string)
        required(:lat).filled(:float)
        required(:lng).filled(:float)
        required(:address).maybe(:string)
        required(:info).maybe(:string)
        required(:amenities).maybe(:array)
        required(:images).hash do
          required(:rooms).maybe(:array)
          required(:amenities).maybe(:array)
        end
      end
    end
  end
end
