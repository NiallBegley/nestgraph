Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations"
}

resources :users do
  collection do
    post 'login'
  end
end


  root "devices#index"
  resources :records do
    collection do
      get "api_endpoint"
    end
  end

  resources :devices do
    collection do
      get "refresh"
      get "api_endpoint"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
