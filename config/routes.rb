Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/users/sessions',
    registrations: 'public/users/registrations',
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
  end

  #以下管理者のルーティング
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  namespace :admin do
  end
end
