Rails.application.routes.draw do
  namespace :api do
    post '/users/login', to: 'users#login'
    resources :users
    resources :tweets
  end
end
