# frozen_string_literal: true

require 'spec_helper'
require 'managing_hotels/importing/paperfiles/transformation'

RSpec.describe ManagingHotels::Importing::Paperfiles::Transformation do
  subject(:transformation) { described_class.new }

  let(:input) do
    [
      {
        "hotel_id": "iJhz",
        "destination_id": 5432,
        "hotel_name": "Beach Villas Singapore",
        "details": "Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.",
        "location": {
          "address": "8 Sentosa Gateway, Beach Villas, 098269",
          "country": "Singapore"
        },
        "amenities": {
          "general": [
            "outdoor pool",
            "indoor pool",
            "business center",
            "childcare"
          ],
          "room": [
            "tv",
            "coffee machine",
            "kettle",
            "hair dryer",
            "iron"
          ]
        },
        "images": {
          "rooms": [
            {
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
              "caption": "Double room"
            },
            {
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
              "caption": "Double room"
            }
          ],
          "site": [
            {
              "link": "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
              "caption": "Front"
            }
          ]
        },
        "booking_conditions": [
          "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
          "Pets are not allowed.",
          "WiFi is available in all areas and is free of charge.",
          "Free private parking is possible on site (reservation is not needed).",
          "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
        ]
      }
    ]
  end

  it 'transforms the input correctly' do
    expect(transformation.call(input)).to eq(
      [
        {
          external_id: "iJhz",
          destination_id: 5432,
          name: "Beach Villas Singapore",
          description: "Surrounded by tropical gardens, these upscale villas in elegant Colonial-style buildings are part of the Resorts World Sentosa complex and a 2-minute walk from the Waterfront train station. Featuring sundecks and pool, garden or sea views, the plush 1- to 3-bedroom villas offer free Wi-Fi and flat-screens, as well as free-standing baths, minibars, and tea and coffeemaking facilities. Upgraded villas add private pools, fridges and microwaves; some have wine cellars. A 4-bedroom unit offers a kitchen and a living room. There's 24-hour room and butler service. Amenities include posh restaurant, plus an outdoor pool, a hot tub, and free parking.",
          location: {
            address: "8 Sentosa Gateway, Beach Villas",
            country: "Singapore",
            zip: "098269",
          },
          amenities: [
            "outdoor_pool",
            "indoor_pool",
            "business_center",
            "childcare",
            "tv",
            "coffee_machine",
            "kettle",
            "hair_dryer",
            "iron"
          ],
          images: [
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/2.jpg",
              description: "Double room"
            },
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/3.jpg",
              description: "Double room"
            },
            {
              url: "https://d2ey9sqrvkqdfs.cloudfront.net/0qZF/1.jpg",
              description: "Front"
            }
          ],
          booking_conditions: [
            "All children are welcome. One child under 12 years stays free of charge when using existing beds. One child under 2 years stays free of charge in a child's cot/crib. One child under 4 years stays free of charge when using existing beds. One older child or adult is charged SGD 82.39 per person per night in an extra bed. The maximum number of children's cots/cribs in a room is 1. There is no capacity for extra beds in the room.",
            "Pets are not allowed.",
            "WiFi is available in all areas and is free of charge.",
            "Free private parking is possible on site (reservation is not needed).",
            "Guests are required to show a photo identification and credit card upon check-in. Please note that all Special Requests are subject to availability and additional charges may apply. Payment before arrival via bank transfer is required. The property will contact you after you book to provide instructions. Please note that the full amount of the reservation is due before arrival. Resorts World Sentosa will send a confirmation with detailed payment information. After full payment is taken, the property's details, including the address and where to collect keys, will be emailed to you. Bag checks will be conducted prior to entry to Adventure Cove Waterpark. === Upon check-in, guests will be provided with complimentary Sentosa Pass (monorail) to enjoy unlimited transportation between Sentosa Island and Harbour Front (VivoCity). === Prepayment for non refundable bookings will be charged by RWS Call Centre. === All guests can enjoy complimentary parking during their stay, limited to one exit from the hotel per day. === Room reservation charges will be charged upon check-in. Credit card provided upon reservation is for guarantee purpose. === For reservations made with inclusive breakfast, please note that breakfast is applicable only for number of adults paid in the room rate. Any children or additional adults are charged separately for breakfast and are to paid directly to the hotel."
          ]
        }
      ]
    )
  end
end
