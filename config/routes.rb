Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/:id/subscriptions', to: 'subscriptions#index'
      post '/subscribe', to: 'subscriptions#create'
      patch '/cancel/:id', to: 'subscriptions#update'
      get '/teas', to: 'teas#index'
    end
  end
end
