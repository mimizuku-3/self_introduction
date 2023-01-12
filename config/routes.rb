Rails.application.routes.draw do
  get "introductions/new" => "introductions#new"
  post "introductions/confirm"=> "introductions#confirm"

  get "/" => 'introductions#index'
end
