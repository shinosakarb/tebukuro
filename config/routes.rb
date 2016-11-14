Rails.application.routes.draw do
  resources :communities, :defaults => { :format => 'json' } do
      resources :events do
        resources :tickets
      end
      resources :admins
      resources :owners
      resources :members
    end
end
