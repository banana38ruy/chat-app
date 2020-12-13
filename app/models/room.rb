class Room < ApplicationRecord
  #MessageモデルとRoomモデルにdependent: :destroyを記述する
  #room（親モデル）が削除されたときに関連付けしているMessage（小モデル）と
  #RoomUser(小モデル)も削除される
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy
  #設計図に記されていたのはmessagesだけがアソシエーションではない
  #各方面にどうつなぐのかを記述する
  #一つのチャットルームに、メッセージは複数存在する

  validates :name, presence: true
  #チャットルームを新規作成するにあたって ルーム名 は必ず必要
  #上記のバリデーションは ルーム名がpresence（存在）している場合のみ作成可であるという意味
end
#アソシエーションの確認はモデムでやろうね
#roomはroom_usersのトンネルをくぐってusersに無数の触手を突き刺してその組み合わさった情報をroom_usersで所有している
