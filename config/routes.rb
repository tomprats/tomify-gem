Rails.application.routes.draw do
  scope module: :tomify do
    root "pages#root"

    resource :user, only: [:create, :edit, :update]
    resource :session, only: [:new, :create, :destroy]
    get :forgot_password, to: "sessions#forgot_password"
    post :reset_password, to: "sessions#reset_password"
    resource :feedback, only: :create

    namespace :admin do
      root "settings#index"

      resources :pages, only: :index
      resources :settings, only: :index
      resources :sidebars, only: :index
      resources :uploads, only: :index
      resources :users, only: :index

      namespace :api do
        resources :pages, only: [:index, :create, :show, :update, :destroy]
        resources :settings, only: [:index, :create, :show, :update, :destroy]
        resources :sidebars, only: [:index, :create, :show, :update, :destroy]
        resources :uploads, only: [:index, :create, :show, :update, :destroy]
        resources :users, only: [:index, :create, :show, :update, :destroy]
      end
    end

    get ":path", to: "pages#show", as: :page
  end
end
