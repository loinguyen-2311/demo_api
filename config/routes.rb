Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "log_out", to: "sessions#destroy"
      end
      post "facebook", to: "users#facebook"
      post "to_image", to: 'users#text_to_image'
      get 'generate_image', to: 'users#generate_image'
      resources :books ,only: [:index , :show] do
        resources :reviews, only: [:index, :show, :update, :destroy, :create]
      end
    end
  end
end
