# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'requesting invalid routes' do
  context 'with a route that has not been implemented' do
    it 'responds with a 404 and a helpful error' do
      get("#{users_path}/foo/bar")

      expect(response).to have_http_status(:not_found)
      expect(response.body).to match(/endpoint not available/)
    end
  end
end
