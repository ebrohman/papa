# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  resource :users
  resource :visits
end
