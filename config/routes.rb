Rails.application.routes.draw do
  root "projects#index"
  devise_for :users
  resources :projects do
		resources :tasks
		patch '/update-status/:id', to: "tasks#update_status"
  end
end
