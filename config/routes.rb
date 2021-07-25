Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :stages, except: [:destroy] do
      resource :bookmarks, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      member do
        get 'quit'
        patch 'withdraw'
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :reviews do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get 'search' => 'stages#search'

    resources :contacts, only: [:new, :create]
    post 'contacts/confirm' => 'contacts#confirm'
    post 'contacts/back' => 'contacts#back'
    get 'contacts/done' => 'contacts#done'
  end

  # 以下管理者のルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :stages
    resources :users, only: [:index, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update, :destroy]
    get 'search' => 'search#search'
    resources :contacts, only: [:index, :show]
  end
end
