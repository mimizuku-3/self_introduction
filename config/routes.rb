Rails.application.routes.draw do
  root to: 'introductions#index'
  resources :introductions do
    collection do
      post "confirm"
    end
  end
end
