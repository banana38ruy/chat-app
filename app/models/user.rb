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
end
