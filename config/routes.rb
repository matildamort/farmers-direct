Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

 

  get '/products/' =>  "products#index"
  get '/products/new' =>  "products#new"
  get '/products/fruit' => "products#fruit"
  get '/products/vegetable' => "products#vegetable"
  get '/products/meat' => "products#meat"
  get '/products/dairy' => "products#dairy"
  get '/products/pantry' => "products#pantry"

  #Posting to array
  post '/products' => "products#create"
  get '/products/myproduct' => "products#myproduct"
  
  #Send back product to client
  get '/products/:id' => "products#show", as: "product"
  get '/products' => "products#about"
  
  delete '/products/:id' => 'products#destroy'


  
  get '/farmers'  =>  "farmers#index"
  get '/farmers/new'  =>  "farmers#new"
  post '/farmers' =>  "farmers#create"
  get '/farmers/:id' =>  "farmers#show", as: "farmer"
  get '/search', to: "products#search"
  post '/search', to: "products#search"


  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  post 'line_items' => "line_items#create"
  get 'line_items/:id' => "line_items#show", as: "line_item"
  delete 'line_items/:id' => "line_items#destroy"
  
  resources :products
  resources :orders
  resources :line_items
  resources :type


end
