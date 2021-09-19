# frozen_string_literal: true

require 'spec_helper'
require 'managing_hotels/importing/transformations/patagonia'

RSpec.describe ManagingHotels::Importing::Transformations::Patagonia do
  subject(:transformation) { described_class.new }

  let(:input) do
    [{
      "id": "iJhz",
      "destination": 5432,
      "name": "Beach Villas Singapore",
      "lat": 1.264751,
      "lng": 103.824006,
      "address": "8 Sentosa Gateway, Beach Villas, 098269",
      "info": "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.",
      "amenities": [
        "Aircon",
        "Tv",
        "Coffee machine",
        "Kettle",
        "Hair dryer",
        "Iron",
        "Tub"
      ],
      "images": {
        "rooms": [
          {
            "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
            "description": "Double room"
          },
          {
            "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg",
            "description": "Bathroom"
          }
        ],
        "amenities": [
          {
            "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg",
            "description": "RWS"
          },
          {
            "url": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg",
            "description": "Sentosa Gateway"
          }
        ]
      }
    }]
  end

  it 'transforms the input correctly' do
    expect(transformation.call(input)).to eq(
      [
        {
          external_id: "iJhz",
          destination_id: 5432,
          name: "Beach Villas Singapore",
          description: "Located at the western tip of Resorts World Sentosa, guests at the Beach Villas are guaranteed privacy while they enjoy spectacular views of glittering waters. Guests will find themselves in paradise with this series of exquisite tropical sanctuaries, making it the perfect setting for an idyllic retreat. Within each villa, guests will discover living areas and bedrooms that open out to mini gardens, private timber sundecks and verandahs elegantly framing either lush greenery or an expanse of sea. Guests are assured of a superior slumber with goose feather pillows and luxe mattresses paired with 400 thread count Egyptian cotton bed linen, tastefully paired with a full complement of luxurious in-room amenities and bathrooms boasting rain showers and free-standing tubs coupled with an exclusive array of ESPA amenities and toiletries. Guests also get to enjoy complimentary day access to the facilities at Asia’s flagship spa – the world-renowned ESPA.",
          location: {
            lat: 1.264751,
            lng: 103.824006,
            address: "8 Sentosa Gateway, Beach Villas",
            zip: "098269"
          },
          amenities: [
            "aircon",
            "tv",
            "coffee_machine",
            "kettle",
            "hair_dryer",
            "iron",
            "tub"
          ],
          images: [
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
              description: "Double room"
            },
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/4.jpg",
              description: "Bathroom"
            },
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/0.jpg",
              description: "RWS"
            },
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/6.jpg",
              description: "Sentosa Gateway"
            }
          ]
        }
      ]
    )
  end
end
