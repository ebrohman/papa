# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /v1/users' do
  describe 'listing users' do
    it 'returns a list of users' do
      2.times do |i|
        User.create(email: "tom#{i}@papa.com")
      end

      get(users_path)

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).length).to eq(2)
    end
  end
end
