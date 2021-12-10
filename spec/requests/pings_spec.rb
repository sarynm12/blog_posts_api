require 'rails_helper'

RSpec.describe "Pings", type: :request do
  it 'can return a 200' do
    
    get "/api/ping"

    expect(response).to be_successful
  end
end