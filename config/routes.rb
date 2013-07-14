PenaltyKicks::Application.routes.draw do
  
  get "games/index"

  resources :games do
    resources :shots
  end
  
  root :to => 'games#index'

end
