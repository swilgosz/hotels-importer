require 'rails_helper'

RSpec.describe "Api::V1::Hotels", type: :request do
  describe "GET /index" do
    let(:hotel_1) { Hotel.create(destination_id: 1, external_id: 'a') }
    let(:hotel_2) { Hotel.create(destination_id: 2, external_id: 'b') }
    let(:hotel_3) { Hotel.create(destination_id: 2, external_id: 'c') }

    before do
      hotel_1
      hotel_2
      hotel_3
    end

    it 'has :ok status code' do
      get '/api/v1/hotels'
      expect(response).to have_http_status(:ok)
    end

    it 'returns all 3 hotels' do
      get '/api/v1/hotels'
      result = JSON.parse(response.body)
      expected =[hotel_1, hotel_2, hotel_3].map(&:external_id)
      expect(result.map { |i| i['id'] }).to contain_exactly(*expected)
    end

    it 'filters by destination' do
      get '/api/v1/hotels?destination=2'
      result = JSON.parse(response.body)
      expected = [hotel_2, hotel_3].map(&:external_id)
      expect(result.map { |i| i['id'] }).to contain_exactly(*expected)
    end

    it 'filters by hotel_ids' do
      get '/api/v1/hotels?hotels[]=a&hotels[]=b'
      result = JSON.parse(response.body)
      expected = [hotel_1, hotel_2].map(&:external_id)
      expect(result.map { |i| i['id'] }).to contain_exactly(*expected)
    end
  end
end
