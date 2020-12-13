class Message < ApplicationRecord
 belongs_to :room
 belongs_to :user
 # 一つのチャットルームに、メッセージは複数存在します
 # 一人のユーザーは、複数のメッセージを送信できる
 # チャットルームとユーザーの中間テーブルになるよここ
 validates :content, presence: true
 # からの場合はDBに保存させないために
 # validatesはモデルで設定する
end

