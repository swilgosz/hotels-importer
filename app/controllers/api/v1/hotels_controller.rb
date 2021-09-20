module Api
  module V1
    class HotelsController < ApplicationController
      def index
        # Here we need to parse provider 1, 2, 3...
        result = Hotel.all
        render json: result
      end
    end
  end
end
