Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      get  'ping'       => 'ping#show'
      post 'user_token' => 'user_token#create'
      resources :users, only: %i[index create] do
        resources :teams, only: :index, controller: 'user_teams'
      end
      patch 'user'      => 'users#update'
      resources :teams, only: %i[index create destroy]
      resources :games, only: %i[index create destroy]
    end
  end
end

