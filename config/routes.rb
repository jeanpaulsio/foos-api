Rails.application.routes.draw do
  scope :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      resources :users, only: %i[index create update] do
        resources :teams, only: :index, controller: 'user_teams'
      end
      resources :teams, only: %i[index create destroy]
    end
  end
end

