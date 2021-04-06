Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  get :guidelines, to: 'pages#guidelines'
  resources :submit_proposals
  resources :proposal_types
  resources :locations do
    member do
      get :proposal_types
    end
  end
end
