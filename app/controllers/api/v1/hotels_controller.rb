# frozen_string_literal: true

require 'api/v1/endpoints/hotels/index'

module Api
  module V1
    class HotelsController < ApplicationController
      def index
        # Here we need to parse provider 1, 2, 3...
        result = Api::V1::Endpoints::Hotels::Index.new.call(params)
        render json: result
      end
    end
  end
end
