Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/users/sign-in', to: 'authentication#authenticate'
  post '/users/sign-up', to: 'users#create'
end
