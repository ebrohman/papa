# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /v1/users', type: :request do
  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'creating a user' do
    it 'creates a new user' do
      post(users_path,
           params: {
             email: 'foo@bar.com',
             first_name: 'Dan',
             last_name: 'Smith'
           }.to_json,
           headers: headers)

      expect(response).to have_http_status(:created), -> { response.body }

      expect(User.where(email: 'foo@bar.com').exists?).to eq(true)
    end

    context 'when a create user request is invalid - missing email' do
      it 'returns a helpful error about a missing email' do
        post(users_path,
             params: {
               first_name: 'Dan',
               last_name: 'Smith'
             }.to_json,
             headers: headers)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to match(/Missing parameter email/)
      end
    end

    context 'when an email is already taken' do
      it 'returns a helpful message' do
        User.create(email: 'james@foo.com')

        post(users_path,
             params: {
               first_name: 'Dan',
               last_name: 'Smith',
               email: 'james@foo.com'
             }.to_json,
             headers: headers)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to match(/Email has already been taken/)
      end
    end
  end
end
