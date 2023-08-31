Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :colleges do 
    resource :courses
    resource :addresses
  end

  resources :users do
    resource :addresses
    get "find_user" , on: :collection
  end
  get "/colleges/find_college/:course_name", to: "colleges#find_college" 
  resources :courses , :addresses , only: [:index, :destroy, :update,:create]
end