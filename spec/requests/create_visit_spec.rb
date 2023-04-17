# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /v1/visits' do
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'creating a new visit' do
    let!(:member) { User.create!(email: 'foo@bar.com') }
    let(:balance) { 100.00 }
    let!(:account) { member.create_account(balance:) }

    let(:create_visit) do
      lambda do |params|
        post(visits_path,
             params: params.to_json,
             headers:)
      end
    end

    it 'creates a visit' do
      params = {
        member_id: member.id,
        date: DateTime.tomorrow,
        rate: 1.0,
        minutes: 30
      }

      expect { create_visit.call(params) }
        .to change { Visit.count }.by(1)

      create_visit.call(params)

      expect(response).to have_http_status(:created), -> { response.body }
    end

    it 'does not create a visit in the past' do
      params = {
        member_id: member.id,
        date: DateTime.yesterday,
        rate: 1.0,
        minutes: 30
      }

      expect { create_visit.call(params) }
        .not_to change { Visit.count }

      expect(response).to have_http_status(:unprocessable_entity)

      expect(response.body).to match(/date is in the past/)
    end

    it 'does not create a visit for a non-existent member' do
      params = {
        member_id: 90_909_090_909,
        date: DateTime.tomorrow,
        rate: 1.0,
        minutes: 30
      }

      expect { create_visit.call(params) }
        .not_to change { Visit.count }

      expect(response).to have_http_status(:not_found)

      expect(response.body).to match(/Couldn't find User with 'id'=90909090909/)
    end

    context 'when the member does not have enough credit for a visit' do
      let(:balance) { 0 }

      it 'returns a helpful message' do
        params = {
          member_id: member.id,
          date: DateTime.tomorrow,
          rate: 1.0,
          minutes: 30
        }

        expect { create_visit.call(params) }
          .not_to change { Visit.count }

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to match(/Not enough credit to request a visit/)
      end
    end
  end
end
