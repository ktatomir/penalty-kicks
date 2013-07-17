PenaltyKicks::Application.routes.draw do
  
  namespace :api, defaults: {format: :json} do
    resources :games do
      resources :shots
    end
  end
  
  resources :games do
    resources :shots
  end
  
  root :to => 'games#index'

end
