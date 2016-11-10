Rails.application.routes.draw do

  resources :communities, :defaults => { :format => 'json' }, shallow: true do
    resources :events
  end

end
