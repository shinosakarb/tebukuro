# frozen_string_literal: true

Rails.application.routes.draw do
  health_check_routes
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :events do
    member do
      resource 'registrations',
               controller: :registrations,
               only: %i[create destroy]
    end
  end

  resources :participants, only: [] do
    member do
      resource 'attendances',
               controller: :attendances,
               only: %i[update]
    end
  end
end
