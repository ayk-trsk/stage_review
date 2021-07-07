Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :stages, except: [:destroy]
  end

  #以下管理者のルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
end
