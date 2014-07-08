WhoToBlame::Engine.routes.draw do
  root to: 'pages#index'
  resources :footprints, only: [:index, :create]
end
