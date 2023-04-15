# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST - /users', type: :request do
  before do
    Role.create!(name: :member)
    Role.create!(name: :pal)
  end

  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe 'creating a member user' do
    it 'creates a new member user' do
      post(users_path,
           params: {
             email: 'foo@bar.com',
             password: '123456',
             first_name: 'Dan',
             last_name: 'Smith',
             role_name: 'member'
           }.to_json,
           headers:)

      expect(response).to have_http_status(:created)

      expect(User.find_by!(email: 'foo@bar.com').member?).to eq(true)
    end
  end

  describe 'creating a pal user' do
    it 'creates a new pal user' do
      post(users_path,
           params: {
             email: 'foo@bar.com',
             password: '123456',
             first_name: 'Dan',
             last_name: 'Smith',
             role_name: 'pal'
           }.to_json,
           headers:)

      expect(response).to have_http_status(:created)

      expect(User.find_by!(email: 'foo@bar.com').pal?).to eq(true)
    end
  end

  describe 'validation errors' do
    context 'when a create user request is invalid' do
      it 'returns a helpful error about a missing password' do
        post(users_path,
             params: {
               email: 'foo@bar.com',
               first_name: 'Dan',
               last_name: 'Smith',
               role_name: 'member'
             }.to_json,
             headers:)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to match(/Password can't be blank/)
      end

      it 'returns a helpful error about a missing email' do
        post(users_path,
             params: {
               password: 'foobar',
               first_name: 'Dan',
               last_name: 'Smith',
               role_name: 'member'
             }.to_json,
             headers:)

        expect(response).to have_http_status(:unprocessable_entity)

        expect(response.body).to match(/Email can't be blank/)
      end
    end
  end
end
