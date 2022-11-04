Rails.application.routes.draw do

  get 'top' => 'top#index'
  get 'top/intro' => 'top#intro'

  get 'recipes/index' => 'recipes#index'
  get 'books/index' => 'books#index'

  get 'create/index' => 'create#index'
  post 'create/post' => 'create#post'

  get 'signup' => 'users#new'
  post 'signup' => 'users#signup'
  
  get 'signin' => 'users#signin_form'
  post 'signin' => 'users#signin'

  post 'signout' => 'users#signout'

  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
