Rails.application.routes.draw do
  root to: 'dashboard#index'

  devise_for :users

  resources :accas do
    collection do
      get :get_acca
      get :import
      post :import_acca
    end
  end

  resources :selections do
    collection do
    end
  end

  # namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions
    end
  # end
end
