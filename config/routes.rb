Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :communities, :defaults => { :format => 'json' } do
    resources :events
  end
end
