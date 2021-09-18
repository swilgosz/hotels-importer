# frozen_string_literal: true

require 'rails_helper'

RSpec.describe do
  it 'routes to hotels#index' do
    expect(get('/api/v1/hotels')).to route_to(controller: 'api/v1/hotels', action: 'index')
  end
end
