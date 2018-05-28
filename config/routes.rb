Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :destroy]

  resources :ideas do
    resources :reviews, only: [:new, :index, :create, :destroy]
  end

  get('/', { to: 'ideas#index', as: 'root' })
  post('/ideas/:id', {to: 'ideas#index' })
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
