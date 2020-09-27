Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :dummy, only: :index
      resources :events, only: %i[create index show]
      resources :tickets, only: %i[create index show]
      resources :reservations, only: %i[create index show]

      match '*unmatched', to: 'errors#not_found', via: :all
    end
  end
end
