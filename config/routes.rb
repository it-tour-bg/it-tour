TourConf::Application.routes.draw do
  namespace :admin do
    resources :conferences
    resources :speakers

    root to: 'conferences#index'
  end
end
