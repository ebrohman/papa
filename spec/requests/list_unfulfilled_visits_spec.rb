# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /v1/visits/unfulfilled' do
  describe 'listing visits' do
    it 'returns a list of unfulfilled visits' do
      member = User.create!(email: 'tom@papa.com')
      visit = Visit.create!(member: member,
                            date: DateTime.tomorrow,
                            minutes: 30,
                            rate: 1.0)

      get(unfulfilled_visits_path)

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
