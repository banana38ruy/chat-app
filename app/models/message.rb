class Message < ApplicationRecord
 belongs_to :room
 belongs_to :user
 #MessagesテーブルとActive Storageのテーブルで管理された画像ファイルのアソシエーションを記述する
 #has_one_attachedは各レコードとファイルを１：１の関係で紐付けるメソッド
 has_one_attached :image
 # 一つのチャットルームに、メッセージは複数存在します
 # 一人のユーザーは、複数のメッセージを送信できる
 # チャットルームとユーザーの中間テーブルになるよここ
 validates :content, presence: true, unless: :was_attached?
 # 空の場合はDBに保存させないために
 # validatesはモデルで設定する
 # validatesのunlessオプションにメソッド名を指定することで
 def was_attached?
  self.image.attached?   
 end
 # メソッドの返り値がfalseならばバリデーションによる検証を行う
 # という条件を作っている
 # was_attached?メソッドは添付したの？ということで
 # self.image.attached?自分の画像を添付したか？という記述によって
 # 画像があればtrue,なければfalseを返す仕組み
end

