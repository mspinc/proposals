Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'sessions#sign_in'
  get :sign_up, to: 'sessions#sign_up'
  get :guidelines, to: 'pages#guidelines'

  resources :dashboards
  resources :submit_proposals
  resources :proposal_types
  resources :locations do
    member do
      get :proposal_types
    end
  end
end
