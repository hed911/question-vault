require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  concern :has_filter do
    collection do
      get :filter
    end
  end

  resources :question_groups, except: %i[show new create], concerns: :has_filter do
    resources :questions, concerns: :has_filter
  end

  resources :integrations, except: %i[show new create], concerns: :has_filter do
    collection do
      get :form
    end
  end

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :question_groups do 
        member do 
          get :questions
        end
      end
    end
  end
  
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'question_groups#index'
end
