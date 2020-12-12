class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      #何を記録するテーブルですか？
      t.string :name, null: false
      t.timestamps
      #roomsテーブルには"ルーム名のみ"を保存するので、上記のような
      #コードになるんすわ
      #記入し終わったらrails db:migrateしましょうね
    end
  end
end
# rails g model room でテーブルを作成することができる
# この時作るモデル名は単数形になるので注意