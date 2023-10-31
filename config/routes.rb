Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      post '/subscribe', to: 'subscriptions#create'
      patch '/cancel/:id', to: 'subscriptions#update'
    end
  end
end
