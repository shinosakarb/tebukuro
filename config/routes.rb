# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :communities, shallow: true, defaults: { format: 'json' } do
    resources :events do
      resources :tickets do
        resources :subscriptions, only: :create
      end
    end
  end

  resources :events do
    member do
      resource 'registrations',
               controller: :registrations,
               only: %i[create destroy]
    end
  end

  namespace :subscription do
    resources :tickets, only: :destroy
  end
end
