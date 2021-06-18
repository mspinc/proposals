Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
  devise_scope :user do
    root to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  get :guidelines, to: 'pages#guidelines'
  resources :feedbacks, path: :feedback
  get 'dashboards', to: 'proposal_types#index'

  resources :proposals do
    post :latex, to: 'proposals#latex_input'
    collection do
      get :latex, to: 'proposals#latex_output'
      get :'rendered_proposal', to: 'proposals#latex_output'
    end

    resources :invites do
      member do
        post :inviter_response
      end
      collection do
        get :thanks
      end
    end
  end

  resources :survey do
    collection do
      get :survey_questionnaire
      post :submit_survey
    end
  end

  resources :people, path: :person

  resources :submit_proposals do
    collection do 
      get :thanks
    end
  end
  resources :proposal_types do
    resources :proposal_forms do
      member do
        post :clone
        delete :proposal_field
        get :proposal_field_edit
      end
      resources :proposal_fields do
        collection do
          post :latex_text
        end
      end
    end
    member do
      get :location_based_fields
      get :proposal_type_locations
    end
  end
  resources :locations do
    member do
      get :proposal_types
    end
  end
end
