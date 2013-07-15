PenaltyKicks::Application.routes.draw do
  
  namespace :api do
    resources :games do
      resources :shots
      resources :goals
      resources :defendends
    end
  end
  
  resources :games do
    resources :shots
  end
  
  root :to => 'games#index'

end
