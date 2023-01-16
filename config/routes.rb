Rails.application.routes.draw do
  root to: 'introductions#index'
  resources :introductions do
    post :confirm, action: :confirm_new, on: :new
    collection do
      get "complete"
    end
  end
end
