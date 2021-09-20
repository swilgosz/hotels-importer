# frozen_string_literal: true

require 'dry-schema'

module ManagingHotels
  module Importing
    module Acme
      Schema = Dry::Schema.Params do
        required(:Id).filled(:string)
        required(:DestinationId).filled(:integer)
        required(:Name).filled(:string)
        required(:Latitude).maybe(:float)
        required(:Longitude).maybe(:float)
        required(:Address).maybe(:string)
        required(:City).filled(:string)
        required(:Country).filled(:string)
        required(:PostalCode).filled(:string)
        required(:Description).filled(:string)
        required(:Facilities).maybe(:array)
      end
    end
  end
end
