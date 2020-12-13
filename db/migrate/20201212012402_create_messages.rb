class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      #設計図をみて必要な部分だけを記述する、なんでもnull falseをいれるわけじゃない
      #設計図に並べられた順にカラムを記述していく
      t.string :content
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
