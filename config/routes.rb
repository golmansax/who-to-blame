WhoToBlame::Engine.routes.draw do
  root to: 'pages#index'

  snapshot_date_route = {
    '/snapshots/:year/:day/:month' => 'snapshots#show',
    via: [:get],
    # constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ },
    as: 'snapshot_date',
  }
  match snapshot_date_route

  resources :snapshots, only: [:create]
end
