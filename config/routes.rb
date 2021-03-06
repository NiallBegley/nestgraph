Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"}
  root "devices#index"
  resources :records
  resources :devices do
    collection do
      get "refresh"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
