Rails.application.routes.draw do
  resources :ridings, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "ridings#index"
  resources :ridings do
    resources :polling_locations, only: [:edit, :update] do
      collection do
        patch 'update_all'
      end
    end
  end  
end
