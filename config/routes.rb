# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      get 'users' => 'users#index'
      post 'users' => 'users#create'
      delete 'users' => 'users#logout'
      resources :tasks
    end
  end
end
