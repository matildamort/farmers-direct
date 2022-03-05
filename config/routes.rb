Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'carts/show'
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

  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy"
  
  post 'order_items/:id/add' => "order_items#add_quantity", as: "order_item_add"
  post 'order_items/:id/reduce' => "order_items#reduce_quantity", as: "order_item_reduce"
  post 'order_items' => "order_items#create"
  get 'order_items/:id' => "order_items#show", as: "order_item"
  delete 'order_items/:id' => "order_items#destroy"
  
  resources :products
  resources :orders





resources :orders do 
  resources :order_items
end

resources :order_items

end
