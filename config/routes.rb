# frozen_string_literal: true

Rails.application.routes.draw do
  apipie

  namespace :v1, as: '' do
    resources :users
    resources :visits do
      collection do
        get :unfulfilled
        get :fulfilled
        post :fulfill
      end
    end

    get :transactions, controller: :transactions, action: :index
  end
end
