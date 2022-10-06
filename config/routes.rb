Rails.application.routes.draw do
  post '/users/sign-in', to: 'authentication#authenticate'
  post '/users/sign-up', to: 'users#create'

  resources :articles do
    resources :comments do
    end
  end
end
