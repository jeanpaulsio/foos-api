Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :users, only: [:index, :create]
    end
  end
end

