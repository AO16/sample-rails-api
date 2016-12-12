Rails.application.routes.draw do
  namespace :api do
    post '/users/login', to: 'users#login'
    get '/users/:id/timeline/', to: 'users#timeline'
    resources :users
    resources :tweets
    resources :follows
  end
end
