Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'groups#new'
  resources :groups, only: [:create, :index, :show, :destroy] do
    resources :users, only: [:create, :edit, :destroy]
    resources :items, only: [:create, :index, :edit, :update, :destroy]
  end
  patch '/groups/:group_id/items/:item_id/users/:user_id/check', 
      to: 'item_checks#update', 
      as: :group_item_user_check
end
