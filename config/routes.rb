Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'house_images#index'

  resources :house_images, only: [:create, :index]
end
