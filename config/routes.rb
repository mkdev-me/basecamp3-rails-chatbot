Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
    namespace :bugsnag do
      resources :messages, only: :create
    end

    namespace :gitlab do
      resources :messages, only: :create
    end

    namespace :rollbar do
      resources :messages, only: :create
    end

    namespace :v1 do
      resources :messages, only: :create
    end
  end
end