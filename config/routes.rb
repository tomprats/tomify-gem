Rails.application.routes.draw do
  scope module: :tomify do
    root "public/pages#root"

    scope module: :public do
      resource :profile, only: :show
      resource :session, only: :show
      resource :subscription, only: :show
    end

    namespace :admin do
      root "settings#index"

      resources :feedback, only: :index
      resources :pages, only: :index
      resources :settings, only: :index
      resources :sidebars, only: :index
      resources :uploads, only: :index
      resources :users, only: :index
    end

    namespace :api do
      namespace :admin do
        resources :feedback, only: [:index, :show, :update, :destroy]
        resources :pages, only: [:index, :create, :show, :update, :destroy]
        resources :settings, only: [:index, :create, :show, :update, :destroy]
        resources :sidebars, only: [:index, :create, :show, :update, :destroy]
        resources :uploads, only: [:index, :create, :show, :update, :destroy]
        resources :users, only: [:index, :create, :show, :update, :destroy]
      end

      namespace :public do
        resource :feedback, only: :create
        resource :user, only: [:create, :show, :update, :destroy]
        resource :session, only: [:create, :destroy]
        resource :password, only: :create
        resource :subscriptions, only: [:create, :destroy]
        resources :subscriptions, only: :show, param: :email, constraints: { email: /[^\/]+/ }
      end
    end

    get ":path", to: "public/pages#show", as: :page
  end
end
