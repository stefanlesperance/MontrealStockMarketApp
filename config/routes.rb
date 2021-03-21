Rails.application.routes.draw do
  resources :stocks
  devise_for :users
  #get 'home/index'
  root 'home#index'
  get 'home/about'
  match'/stocks/:id', :to => 'stocks#destroy', :as => :destroy_stock, :via => :delete
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end


  #Slightly different route set in comparison to Root/Get. Much more literal with the pointer
  post "/" => 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
