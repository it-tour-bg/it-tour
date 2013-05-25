TourConf::Application.routes.draw do
  namespace :admin do
    resources :conferences

    root to: 'conferences#index'
  end
end
