Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :communities, shallow: true, :defaults => { :format => 'json' } do
    resources :events do
      resources :tickets do
        resources :subscriptions, only: :create
      end
    end
  end
end
