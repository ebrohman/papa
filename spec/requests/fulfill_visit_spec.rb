# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /v1/visits/fulfill' do
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'fulfilling a visit as a pal' do
    let!(:member)         { User.create!(email: 'foo@bar.com') }
    let(:pal)             { User.create!(email: 'pal@papa.com') }
    let(:balance)         { 100.00 }
    let(:rate)            { 1.0 }
    let!(:member_account) { member.create_account(balance:) }
    let!(:pal_account)    { pal.create_account(balance:) }

    let(:visit) do
      Visit.create!(member: member,
                    date: DateTime.yesterday,
                    minutes: 30,
                    rate: rate)
    end

    let(:fulfill_visit) do
      lambda do |params|
        post(fulfill_visits_path,
             params: params.to_json,
             headers: headers)
      end
    end

    it 'fulfills a members visit' do
      params = {
        visit_id: visit.id,
        pal_id: pal.id
      }

      fulfill_visit.call(params)

      expect(response).to have_http_status(:created), -> { puts response.body }
    end

    it 'transfers the visit credit to the pal' do
      params = {
        visit_id: visit.id,
        pal_id: pal.id
      }

      expect { fulfill_visit.call(params) }
        .to change { pal_account.reload.balance }
        .from(100.0).to(125.50) # less 15%
    end

    it 'debits the visit credit from the member' do
      params = {
        visit_id: visit.id,
        pal_id: pal.id
      }

      expect { fulfill_visit.call(params) }
        .to change { member_account.reload.balance }
        .from(100.0).to(70.0)
    end

    context 'when the member balance is insufficient to pay' do
      let(:rate) { 50.0 }

      it 'returns a helpful message' do
        params = {
          visit_id: visit.id,
          pal_id: pal.id
        }

        fulfill_visit.call(params)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to match(/Member does not have enough credit to pay you for this visit/)
      end
    end
  end
end
