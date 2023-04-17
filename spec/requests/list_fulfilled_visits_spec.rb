# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /v1/visits/fulfilled' do
  describe 'listing visits' do
    it 'returns a list of fulfilled visits' do
      member = User.create!(email: 'tom@papa.com')
      visit = Visit.create!(member: member,
                            date: DateTime.yesterday,
                            completed_at: DateTime.yesterday,
                            minutes: 30,
                            rate: 1.0)

      get(fulfilled_visits_path)

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
