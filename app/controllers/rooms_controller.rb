class RoomsController < ApplicationController
  
  def index
      #トップ画面のindex（表示一覧）をする
  end

      #コントローラーを作ったら
      #defでnewメソッド発動
      #@roomを定義する
      #form_withにわたす引数として、値が空のRoomインスタンスを
      #@roomに代入している
  def new
     @room = Room.new #Room爆誕
  end
  
  def create
    #paramsから送られてくる値を確認したい場合は
    #ここにbinding.pryを刺してフォーム送信ボタンを押してからparamsと確認する
    @room = Room.new(room_params)
    if @room.save
      #成功したらルートパスにリダイレクト
      redirect_to root_path
    else
      render :new
      #失敗したらrenderメソッドでrooms/new.html.erbのページを表示
    end
  end 
  
  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
 end
 #roomsコントローラーにdestroyアクションを定義する
 #どのチャットルームを削除するのかを特定する場合
 #room.find(params[:id])を使用して、削除したいチャットルームの情報を取得する

 #destroyアクションは、削除するだけなのでビューの表示は必要ない
 #そのため、インスタンス変数ではなく変数としてroomを定義し
 #destroyメソッドを使用する

 #destoryメソッドが実行されたら、root(roomsのindex)に
 #リダイレクトする記述をする
 #次に、destroyアクションを動かすlink_toを_main_chat.html.erbに設定する
 private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
      #この中に、user＿ids： ［］という記述がある
      #このように、配列に対して保存を許可したい場合は、キーに対し[]を値として
      #記述する
  end
end
