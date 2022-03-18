Rails.application.routes.draw do

  devise_for :users
  root to: "products#index"

 

  get '/products/' =>  "products#index"
  get '/products/new' =>  "products#new"
  post '/products' => "products#create"
  get '/products/fruit' => "products#fruit"
  get '/products/vegetable' => "products#vegetable"
  get '/products/meat' => "products#meat"
  get '/products/dairy' => "products#dairy"
  get '/products/pantry' => "products#pantry"
  get '/products/search' => "products#search"
  post '/products/search' => "products#search"
  #get '/search', to: "products#search"
  #post '/search', to: "products#search"

  #Posting to array
  
  get '/products/myproduct' => "products#myproduct"
  
  #Send back product to client
  get '/products/:id' => "products#show", as: "product"
  get '/products' => "products#about"
  
  delete '/products/:id' => 'products#destroy'


  
  get '/farmers'  =>  "farmers#index"
  get '/farmers/new'  =>  "farmers#new"
  post '/farmers/new'  =>  "farmers#new"
  post '/farmers' =>  "farmers#create"
  get '/farmers/mypage' => "farmers#mypage"
  get '/farmers/:id' =>  "farmers#show", as: "farmer"
  


  resources :farmers do
    member do
      delete :delete_photo
    end
  end


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
  resources :farmers


end
