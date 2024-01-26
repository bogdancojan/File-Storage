Rails.application.routes.draw do
  root "documents#index"
  resources :documents, only: [:index, :destroy] do
    collection do
      post :upload
    end
    member do
      get :download
    end
  end
end
