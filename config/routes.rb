Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'carts/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  

  root to: "products#index"


  get '/products/' =>  "products#index"
  get '/products/new' =>  "products#new"

  #Posting to array
  post '/products' => "products#create"
  
  #Send back product to client
  get '/products/:id' => "products#show", as: "product"
  
  delete '/products/:id' => 'products#destroy'


  get '/farmers'  =>  "farmers#index"
  get '/farmers/new'  =>  "farmers#new"
  post '/farmers' =>  "farmers#create"
  get '/farmers/:id' =>  "farmers#show", as: "farmer"

  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  
  resources :products
  resources :orders


end
