class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  # Userモデルにvalidates :name, presence: trueを追記する
  # "nameカラム"にpresence: trueを設けることで、"空の場合はDBに保存しない"というバリデーションを設定している
  # 入力フォームを空にしたままアカウントを作成しようとした場合これでエラーを起こしてアカウントを作成できないようにする
  # 送られるデータのあるモデルに着目する
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  # 設計書でアソシエーションを確認する際はそのモデルが何とつながるかを全部把握して記述すること
  # 一人のユーザーは、複数のメッセージを送信できる
  # room_usersにたくさん触手をつきさす
  # userはroom_usersのトンネルをくぐってroomsに無数の触手を突き刺して組み合わせたデータをroom_usersで所有している
end

