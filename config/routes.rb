Rails.application.routes.draw do
  resources :categories
  resources :assets
  resources :movements
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'import' => 'import_movements#index'
  post 'import' => 'import_movements#import'

  namespace :graphs do
    get '' => 'simple_graphs#index'
    get 'credits_vs_debits' => 'simple_graphs#credits_vs_debits'
    get 'movements_by_day' => 'simple_graphs#movements_by_day'
  end

  root "movements#index"
end
