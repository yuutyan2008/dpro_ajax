Rails.application.routes.draw do
  root 'blogs#index'
  resources :blogs do
    resources :favorites, only: [:create, :destroy]
  end
  # deviseを導入するとログイン中のユーザをcurrent_userとすることが出来る
  devise_for :users
end
