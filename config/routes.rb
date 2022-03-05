Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  

  root to: "products#index"
  get '/products/', to: "products#index"
  get '/products/new', to: "products#new"

  #Posting to array
  post '/products', to: "products#create"
  
  #Send back product to client
  get '/products/:id', to: "products#show", as: "product"
  
  delete '/products/:id' => 'products#destroy'



  get '/farmers', to: "farmers#index"
  get '/farmers/new', to: "farmers#new"
  post '/farmers', to: "farmers#create"
  get '/farmers/:id', to: "farmers#show", as: "farmer"

get '/orders', to: "orders#index"
get '/orders/new', to: "orders#new"
post '/orders', to: "orders#create"
get '/orders/:id', to: "orders#show", as: "order"


get '/order_items', to: "order_items#index"
post '/order_items', to: "order_items#create"
get '/order_items/:id', to: "order_items#show", as: "order_item"
get '/order_items', to: "order_items#destroy"

end
