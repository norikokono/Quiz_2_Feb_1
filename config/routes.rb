Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root 'welcome#home'
    get('/about', { to: 'welcome#about', as: :about })
    get('/contact_us', { to: 'welcome#contact_us', as: :contact })

    get('/home', to: 'welcome#home')
    
    post('/thank_you', to: 'welcome#thank_you')

    resources :users, ony: [:new, :create]
    resource :user, only: [:edit, :update]
    resource :session, only: [:new, :create, :destroy]

    resources :ideas do
      resources :reviews, only: [:create, :destroy] 
      resources :likes, shallow: :true, only: [:create, :destroy]
      resources :joins, shallow: :true, only: [:create, :destroy]

      get :liked, on: :collection
      get :joined, on: :collection
  end

end