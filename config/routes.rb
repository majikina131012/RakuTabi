Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'groups#new'
  get 'about', to: 'groups#about'

  resources :groups, only: [:create, :index, :show, :destroy] do
    resources :votes, only: [:new, :create, :index]
    resources :items, only: [:create, :index, :edit, :update, :destroy]
    resources :users, only: [:create, :edit, :update, :destroy]
    patch 'bulk_update_item_checks', to: 'item_checks#bulk_update'
    get 'detail', to: 'expenses#detail'
    resources :expenses, only: [:create, :index, :edit, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end

  match "*path", to: "groups#error", via: :all
  patch '/groups/:group_id/items/:item_id/users/:user_id/check', 
      to: 'item_checks#update', 
      as: :group_item_user_check
end
