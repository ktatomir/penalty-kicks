PenaltyKicks::Application.routes.draw do
  
  namespace :api do
    resources :games do
      resources :shots
    end
  end
  
  resources :games do
    resources :shots
  end
  
  root :to => 'games#index'

end
