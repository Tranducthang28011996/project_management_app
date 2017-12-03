Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root "projects#index"
  devise_for :users
  patch "edit/avatar", to: "users#update_avatar", as: "edit_avatar"
  resources :projects do
		resources :tasks
  end
	patch '/update-label/:id', to: "tasks#update_label"
  resources :teams
  resources :users
  resources :search
  mount ActionCable.server => '/cable'
end
