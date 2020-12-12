class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users

  validates :name, presence: true
  #チャットルームを新規作成するにあたって ルーム名 は必ず必要
  #上記のバリデーションは ルーム名がpresence（存在）している場合のみ作成可であるという意味
end
#アソシエーションの確認はモデムでやろうね
#roomはたくさんのroom_usersのトンネルをくぐってusersに突き刺して所有している
