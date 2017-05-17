Rails.application.routes.draw do
  root "pages#show", page: "home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/pages/:page" => "pages#show"
  get "beer" => "events#beer"
  get "chat" => "events#chat"

  resources :events, only: [ :index ]

  namespace :api, defaults: { format: :json } do
    resources :events, only: [ :create ]
  end

  get "/:device_id", to: "events#user", as: :user
end
