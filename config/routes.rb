Rails.application.routes.draw do
  devise_for :users
  #↓トップ画面を変更したい時原点に戻る時の場所を変えたらこのルートパスを変える 住所変更
  root to: "rooms#index"
   #作成するコントローラーにアクションを定義する
   #基本的なアクションはCRUD
   #railsではそれを７つに分ける
   #resourcesはその７つが詰まったお得セット
   #resources :必要とする住所 これだとそのまま７つ付与
   #resources :必要とする住所, only: [:付与したいアクション, :付与したいアクション ]と記述する
  resources :users, only: [:edit, :update]
  #新規チャットルームの作成で動くアクションはnewとcreateだから
  #そして部屋ごとにresourcesは設定する
  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index,:create]
    #メッセージ送信機能に必要なindexとcreateのルーティングを記述したい
    #メッセージを投稿する際には、どのルームで投稿されたメッセージなのかをパスから判断できるようにしたいので
    #ルーティングのネストを利用して記述している
    #今回の場合、ネストすることにより、roomsが親 messagesが子 という親子関係になるので 
    #チャットルームに属しているメッセージという意味になる
    #設定したらrails routesでチャットルームのリンクを探す
    #roomのアクションにdestroyを加える
  end
end
