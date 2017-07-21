Rails.application.routes.draw do

  root to: redirect('users/login')

  get '/products' => 'products#index'

  post "/products" => "products#create"

  delete "/products/:id" => "products#destroy"

  post "/products/:id/buy" => "products#buy"




  

  

  get '/users/login' => 'users#new'

  post '/users' => 'users#create'

  get '/users/logout' => 'users#logout'

  post '/users/login' => 'users#authenticate'

  get '/users/:id' => 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
