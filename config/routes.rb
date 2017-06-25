Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  api_actions = [:create, :get, :index, :update, :destroy, :show] # we don't need new and edit since we are using api only

  namespace :api, defaults: { format: 'json' } do
    resources :examples, only: api_actions
    resources :conversations, only: [:show, :create]
  end
end
