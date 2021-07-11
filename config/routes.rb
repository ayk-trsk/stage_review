Rails.application.routes.draw do
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/quit'
  end


  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :stages, except: [:destroy]
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'quit'
        patch 'withdraw'
      end
    end
    resources :reviews
  end

  #以下管理者のルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :stages
    resources :users, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
  end
end
