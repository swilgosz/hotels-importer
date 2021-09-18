require 'rails_helper'

RSpec.describe "Api::V1::Hotels", type: :request do
  describe "GET /index" do
    it 'has :ok status code' do
      get '/api/v1/hotels'
      expect(response).to have_http_status(:ok)
    end
  end
end
