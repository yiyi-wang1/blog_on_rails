Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  resources :posts do
      resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update]

  get 'users/:id/edit_password', to: 'users#edit_password', as: :edit_password_user

  patch 'users/:id/change_password', to: 'users#change_password', as: :change_password_user

  resource :session, only: [:create, :new, :destroy]
end
