Rails.application.routes.draw do
  resources :communities, shallow: true, :defaults => { :format => 'json' } do
    resources :events do
      resources :tickets
    end
  end
end
