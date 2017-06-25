Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_actions = [:create, :get, :index, :update, :destroy, :show] # we don't need new and edit since we are using api only

  namespace :api, defaults: { format: 'json' } do
    resources :examples, only: api_actions
    resource :registration, only: [:create]
    resource :session, only: [:create, :destroy]
    
    resources :conversations, only: [:show, :create]
    resource :user, only: [:show]
    resources :participants, only: [:create, :destroy]
    resources :messages, only: [:create]
  end
end
