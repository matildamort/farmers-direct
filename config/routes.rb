Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "products#index"
  get '/products/', to: "products#index"
  get '/products/new', to: "products#new"

  #Posting to array
  post '/products', to: "products#create"
  
  #Send back product to client
  get '/products/:id', to: "products#show", as: 'product'
  



end
