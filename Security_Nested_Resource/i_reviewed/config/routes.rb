Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources gives all 7 actions but we need only 2 for notes for now
  resources :books do
    resources :notes, only: [:create, :destroy] # nested resources.
  end

  root 'books#index'
end
