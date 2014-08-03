WhoToBlame::Engine.routes.draw do
  root to: 'pages#index'

  snapshots_date_route = {
    '/snapshots/:year/:day/:month' => 'snapshots#index',
    via: [:get],
    # constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ },
    as: 'snapshots_date',
  }

  match snapshots_date_route

  resources :snapshots, only: [:index, :create]
end
