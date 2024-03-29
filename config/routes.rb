Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # api_actions = [:create, :get, :index, :update, :destroy, :show] # we don't need new and edit since we are using api only

  namespace :api, defaults: { format: 'json' } do
    root to: proc { [404, {}, ["Not found."]] }
    
    resource :registration, only: :create
    resource :session, only: [:create, :destroy]
    resource :pusher_auth, only: :create

    resource :user, only: [:show, :update]

    resources :conversations, only: [:create, :index, :show] do
      resources :transactions, only: [:create, :index]
    end

    resources :transactions, only: :show
    resources :transaction_verifications, only: :update
    resource :qiwi_attach, only: [:show, :create]
    resource :qiwi_payment, only: :create
  end
end
