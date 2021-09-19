# frozen_string_literal: true

require 'dry-inflector'

module ManagingHotels
  module Importing
    module Patagonia
      class Inflector < Dry::Inflector
        def strip(str)
          str.respond_to?(:strip) ? str.strip : str
        end

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

      module Functions
        extend Dry::Transformer::Registry

        inflector = Inflector.new
        import :strip, from: inflector
        import :underscore, from: inflector
        import :extract_zip, from: inflector
        import :flatten, from: inflector
        import :parameterize, from: inflector
      end
    end
  end
end
