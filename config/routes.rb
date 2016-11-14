Rails.application.routes.draw do
  resources :communities, :defaults => { :format => 'json' } do
      resources :events
    end
end
