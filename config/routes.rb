Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'groups#new'
  resources :groups, only: [:create, :index, :show, :destroy] do
    resources :users, only: [:create, :edit, :destroy]
    resources :expenses, only: [:create, :show, :edit, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
end
