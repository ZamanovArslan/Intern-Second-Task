Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :events, except: [:show]
  namespace "api" do
    namespace "v1" do
      resources :events, only: %i[create destroy index]
    end
  end
end
