# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Following was generated by rails generate controller. concise way is shown below
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'

  # resources gives all 7 actions but we need only 2 for notes for now
  resources :books do
    # resources :notes, only: [:create, :destroy] # nested resources.
    # %i for array fo symbols and %w for array of words/strings
    resources :notes, only: %i[create destroy] # nested resources.
  end

  # resources :sessions, only: [:new, :create, :destroy]
  resources :sessions, only: %i[new create destroy]

  # 'as' give us ability to use login_path and logout_path for below
  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  root 'books#index'
end
