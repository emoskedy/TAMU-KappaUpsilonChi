# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'homepage#index'

  get '/faq', to: 'homepage#faq'

  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    delete 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  resources :checks do
    member do
      get 'review'
      patch 'update_review'
    end
    collection do
      get 'past'
      get 'approved'
      get 'denied'
    end
    resources :notes
  end

  resources :people
  resources :sub_accounts
  get '/admin', to: 'admins/admin#admin'
  post '/update', to: 'admins/admin#update'
  get '/search', to: 'admins/admin#search'

  namespace :admins do
    resources :admin, only: %i[index create new destroy]
    post 'update', to: 'admin#update', as: 'update'
    get 'search', to: 'admin#search', as: 'search'
  end
end

