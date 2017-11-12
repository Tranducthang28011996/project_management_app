Rails.application.routes.draw do
  root "projects#index"
  devise_for :users
  patch "edit/avatar", to: "users#update_avatar", as: "edit_avatar"
  resources :projects do
		resources :tasks
		patch '/update-status/:id', to: "tasks#update_status"
  end
  resources :teams
  resources :users
end
