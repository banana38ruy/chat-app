class MessagesController < ApplicationController
  def index
    #@messageには、Message.newで生成した、 Messageモデルのインスタンス情報
    #代入する
    #@roomには、Room.find(params[:room_id])と記述することで、　
    # paramsに含まれているroom_id を代入する
    
    @message = Message.new
    @room = Room.find(params[:room_id])
    #直前の問題にあった通りルーティングをネストしているため
    #/rooms/:room_id/messagesといったパスになる
    #パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に
    #room_idという値が存在している
    #そのため、params[:room_id]と記述することで
    #room_idを取得することができる
  end

  def create
    #messagesコントローラーにcreateアクションを定義する（保存のアクション）
    @room = Room.find(params[:room_id])#紐付いたIDを探したものをroomに代入
    @msessage = @room.messages.new(message_params)#代入した@roomを@room.messages.newとしてインスタンスを生成し
    #(message_params)を引数にして、privateメソッドを呼び出す
    @message.save#まとめられた値をsaveで最後に記録する
    if @message.save
      #記録に成功したらmessagesコントローラーのindexアクションに再度リクエストを送信し、
      #新たにインスンタンス変数を生成する
      #これによって保存後の情報に更新される
      redirect_to room_messages_path(@room)#routes_pathでroom_messagesを確認する
    else
      render :index
      #保存に失敗した場合はindexアクションのindex.html.erbを表示するように指定している
      #このとき、indexアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻る
  end

 
  

  private

  def message-params
    #privateメソッドとしてmessage_paramsを定義し、メッセージの内容
    #（content)をmessagesテーブルへ保存できるようにする
    #パラメーターの中にログインしているユーザーのidと紐付いている、メッセージの内容(contentを受け取るように許可する)
    params.require(:message).permit(:content).merge(user_id: current_user.id)
end
