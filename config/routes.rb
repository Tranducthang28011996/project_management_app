Rails.application.routes.draw do
  root "projects#index"
  devise_for :users
  resources :users, only: %i(show edit update)
  patch "edit/avatar", to: "users#update_avatar", as: "edit_avatar"
  resources :projects do
		resources :tasks
		patch '/update-status/:id', to: "tasks#update_status"
  end
  resources :teams
  resources :users
end
