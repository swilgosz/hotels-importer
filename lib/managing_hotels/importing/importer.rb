# frozen_string_literal: true

require 'net/http'
require 'json'

require 'managing_hotels/importing/acme/adapter'
require 'managing_hotels/importing/patagonia/adapter'
require 'managing_hotels/importing/paperflies/adapter'

module ManagingHotels
  module Importing
    class Importer
      def call
        acme = Acme::Adapter.new.call
        patagonia = Patagonia::Adapter.new.call
        paperflies = Paperflies::Adapter.new.call
        all = paperflies | acme | patagonia

        res = all.each_with_object({}) do |item, obj|
          id = item[:external_id]
          obj[id] ||= {}
          item.each do |k, v|
            obj[id][k] ||= v

            obj[id][k] = v if (k == :description) && (v&.length || 0) > (obj[id][k]&.length || 0)
            obj[id][k] = (obj[id][k] | v).uniq if obj[id][k].is_a?(Array) && v.is_a?(Array)
          end
          # Move to ActiveRecord::Import if there is a time for it.
        end.values

        Hotel.delete_all
        Hotel.create(res)
      end
    end
  end
end
