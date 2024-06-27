Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions',
  passwords: 'users/passwords'
  }
  scope "(:locale)", locale: /ja|en/ do
  root "books#index"
  resources :books
  resources :users, only: [:show, :index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
