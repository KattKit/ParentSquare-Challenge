Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "application#index"

  post "/webhook", to: "webhook#index"

  namespace "api" do
    resources "message", only: [:index, :show, :create]
    resources "phone_number", only: [:index, :show ]
    resources "admin", only: [:show]
    resources "event", only: [:index, :show]
  end
end
