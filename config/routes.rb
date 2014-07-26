WhoToBlame::Engine.routes.draw do
  root to: 'pages#index'

  footprints_date_route = {
    '/footprints/:year/:day/:month' => 'footprints#index',
    via: [:get],
    # constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ },
    as: 'footprints_date',
  }

  match footprints_date_route

  resources :footprints, only: [:index, :create]
end
