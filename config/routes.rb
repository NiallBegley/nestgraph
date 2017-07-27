Rails.application.routes.draw do
  resources :records
  resources :devices do
    collection do
      get "refresh"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
