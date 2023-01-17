Rails.application.routes.draw do
  root to: 'introductions#index'
  resources :introductions do
    post :confirm, action: :confirm_new, on: :new
    patch :confirm, action: :confirm_edit, on: :member
    get :complete, action: :complete, on: :collection
  end
end