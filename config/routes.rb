# frozen_string_literal: true

Rails.application.routes.draw do
  apipie

  namespace :v1, as: '' do
    resources :visits, only: %i[get post] do
      collection do
        get :unfulfilled
        get :fulfilled
        post :fulfill
        post :create
      end
    end

    get :users, controller: :users, action: :index
    post :users, controller: :users, action: :create

    get :transactions, controller: :transactions, action: :index
  end

  match '*route_not_found', to: 'application#route_not_found', via: %i[get post]
end
