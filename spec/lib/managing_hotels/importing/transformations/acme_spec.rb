# frozen_string_literal: true

require 'spec_helper'
require 'managing_hotels/importing/transformations/acme'

RSpec.describe ManagingHotels::Importing::Transformations::Acme do
  subject(:transformation) { described_class.new }

  let(:input) do
    [{
      "Id": "iJhz",
      "DestinationId"=>5432,
      "Name"=>"Beach Villas Singapore",
      "Latitude"=>1.264751,
      "Longitude"=>103.824006,
      "Address"=>" 8 Sentosa Gateway, Beach Villas ",
      "City"=>"Singapore",
      "Country"=>"SG",
      "PostalCode"=>"098269",
      "Description"=>
      "  This 5 star hotel is located on the coastline of Singapore.",
      "Facilities"=> [
        "Pool",
        "BusinessCenter",
        "WiFi ",
        "DryCleaning",
        " Breakfast"
      ]
    }]
  end

  it 'transforms the input correctly' do
    expect(transformation.call(input)).to eq(
      [{
        external_id: "iJhz",
        destination_id: 5432,
        name: "Beach Villas Singapore",
        description: "This 5 star hotel is located on the coastline of Singapore.",
        location: {
          lat: 1.264751,
          lng: 103.824006,
          address: "8 Sentosa Gateway, Beach Villas",
          city: "Singapore",
          country: "SG",
          zip: "098269",
        },
        amenities: [
          "pool",
          "business_center",
          "wifi",
          "dry_cleaning",
          "breakfast"
        ]
      }]
    )
  end
end
