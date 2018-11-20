Rails.application.routes.draw do
  resources :user, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
