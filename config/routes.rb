Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: 'groups#new'
  root to: "events#index"
  get '/events', to: 'events#index', defaults: { format: 'json' }
  # resources :groups, only: [:create, :index, :show, :destroy] do
  #   resources :users, only: [:create, :edit, :destroy]
  #   resources :events, only: [:index], defaults: { format: 'json' } do
  #     resources :votes, only: [:index, :create]
  #   end
  # end
end
