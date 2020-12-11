class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users
end
#アソシエーションの確認はモデムでやろうね
#roomはたくさんのroom_usersのトンネルをくぐってusersに突き刺して所有している
