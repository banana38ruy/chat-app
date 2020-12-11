Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
   #作成するコントローラーにアクションを定義する
   #基本的なアクションはCRUD
   #railsではそれを７つに分ける
   #resourcesはその７つが詰まったお得セット
   #resources :必要とする住所 これだとそのまま７つ付与
   #resources :必要とする住所, only: [:付与したいアクション, :付与したいアクション ]と記述する
  resources :users, only: [:edit, :update]
end
