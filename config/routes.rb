# frozen_string_literal: true

Rails.application.routes.draw do
  apipie

  namespace :v1, as: '' do
    resource :users
    resource :visits
  end
end
