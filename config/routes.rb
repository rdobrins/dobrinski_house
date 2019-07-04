Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'house_images#show'

  get 'house_images/:client_token', :to => 'house_images#index'
  resources :house_images, only: [:show]
  resources :fragments, only: [:create]
  get 'locations', to: 'locations#index', :defaults => { :format => 'json' }
end
