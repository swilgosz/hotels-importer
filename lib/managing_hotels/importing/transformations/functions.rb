# frozen_string_literal: true

require 'dry-inflector'

module ManagingHotels
  module Importing
    class Inflector < Dry::Inflector
      def strip(str)
        str.respond_to?(:strip) ? str.strip : str
      end
    end

    module Functions
      extend Dry::Transformer::Registry

      inflector = Inflector.new do |inflections|
        inflections.acronym "WiFi"
      end
      import :underscore, from: inflector
      import :strip, from: inflector
    end
  end
end
