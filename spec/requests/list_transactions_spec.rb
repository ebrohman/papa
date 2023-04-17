# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET - /v1/transactions' do
  describe 'listing transactions' do
    it 'returns a list of visit transactions' do
      member = User.create!(email: 'tom@papa.com')
      pal = User.create!(email: 'tom2@papa.com')
      visit = Visit.create!(member: member,
                            date: DateTime.yesterday,
                            completed_at: DateTime.yesterday,
                            minutes: 30,
                            rate: 1.0)
      Transaction.create!(member: member, pal: pal, amount: 30.0)

      get(transactions_path)

      expect(response).to have_http_status(:ok)

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end
