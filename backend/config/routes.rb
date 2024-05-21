# frozen_string_literal: true

Rails.application.routes.draw do
  use_doorkeeper
  post   "/signup", to: "registations#create"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#logout"
  # current_user エンドポイント作成
  get    "/current_user", to: "users#current"
  # get    "/current_team", to: "current_team#show"
  # get    "/current_team_member", to: "current_team_member#show"

  # 自分のプロフィールページ用のエンドポイント
  get    '/profile', to: 'users#profile'
  # 自分のテーム情報を取得するエンドポイント
  get    '/team',    to: 'teams#current_team'

  resources :users, only: [:show, :update, :destroy]
  resources :registrations, only: [:create]
  resources :sessions, only: [:create, :destroy]
  resource :passwords, only: [:update] do
    post :reset, on: :collection
  end
  resources :emails, only: [:update]
  resources :teams do
    resources :recruitments, only:[:create, :index]
  end
  resources :recruitments do
    collection do
      get    '/by_team/:team_id', to: 'recruitments#by_team'
    end
  end
  resources :teams, only: [:show]
end
