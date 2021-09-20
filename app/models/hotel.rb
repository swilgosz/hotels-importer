# frozen_string_literal: true

class Hotel < ApplicationRecord
  scope :by_destination, -> (destination_id) { where(destination_id: destination_id) }
  scope :by_ids, -> (ids) { where(external_id: ids) }
end
