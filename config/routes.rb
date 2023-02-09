Rails.application.routes.draw do
  root to: 'introductions#index'
  resources :introductions do
    post :confirm, action: :confirm_new, on: :new
    patch :confirm, action: :confirm_edit, on: :member
    get :complete, action: :complete, on: :collection
    get :search, action: :search, on: :collection
  end
  resources :basic_work_experiences
  resources :work_experiences
end