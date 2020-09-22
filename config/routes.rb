Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :dummy, only: :index
    end
  end
end
