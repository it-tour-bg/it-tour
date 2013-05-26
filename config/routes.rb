TourConf::Application.routes.draw do
  namespace :admin do
    resources :conferences
    resources :events
    resources :speakers

    root to: 'conferences#index'
  end
end
