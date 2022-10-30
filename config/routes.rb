Rails.application.routes.draw do

  get '/' => 'top#index'
  get 'recipes/index' => 'recipes#index'
  get 'books/index' => 'books#index'
  get 'create/index' => 'create#index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
