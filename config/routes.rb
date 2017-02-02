Rails.application.routes.draw do
  scope module: :tomify do
    root "pages#root"

    resource :user, only: [:create, :edit, :update]
    resource :session, only: [:new, :create, :destroy]
    get :forgot_password, to: "sessions#forgot_password"
    post :reset_password, to: "sessions#reset_password"
    resource :feedback, only: :create

    get ":path", to: "pages#show", as: :page
  end
end
