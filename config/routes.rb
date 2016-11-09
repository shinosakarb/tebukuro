Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :communities, :defaults => { :format => 'json' } do
    resources :events
  end

end
