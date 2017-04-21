Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :commands, defaults: {format: :json} do
  end

  namespace :api, defaults: {format: :json} do
    namespace :bugsnag do
      resources :messages, only: :create
    end

    namespace :gitlab do
      resources :messages, only: :create
    end

    namespace :giphy do
      resources :messages, only: :create
    end

    namespace :rollbar do
      resources :messages, only: :create
    end

    namespace :sns do
      resources :messages, only: :create
    end
  end
end
