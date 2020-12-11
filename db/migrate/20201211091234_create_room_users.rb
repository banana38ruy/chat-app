class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      #今回はreferences型を使う こいつは外部キーのカラムを追加する際に用いる型なのさ
      #中間テーブルのために別テーブルのカラムが参照したいからこいつを使うのねん
      #t.references :住所, foreign_key: trueてな具合に記述する
      #今回は互いに参照したいroomとuserをつなぐ
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
#modelを作ったら db をまず参照すること！
#数字の羅列しているやつから手を付ける
