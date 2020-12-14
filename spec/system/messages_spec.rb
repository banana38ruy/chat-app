require 'rails_helper'

RSpec.describe "メッセージ投稿機能", type: :system do
  before do
    # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
    @room_user = FactoryBot.create(:room_user)
    #associationメソッドをFactoryBotに定義したおかげでassociationで定義したインスタンスも一緒に生成することができる
  end

  context '投稿に失敗したとき' do
    it '送る値が空の為、メッセージの送信に失敗すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # DBに保存されていないことを確認する
      expect{
        find('input[name="commit"]').click
      }.not_to change { Message.count }
      #メッセージを送信するためにfindメソッドを使用して、送信ボタンの
      # input[name="commit"] 要素を取得してクリックしている
      # しかし、何も入力を行っていないので、データベースのmessageモデルのカウントが増えていないことを
      # 確認している

      # 元のページに戻ってくることを確認する
      expect(current_path).to eq room_messages_path(@room_user.room)
      # rails routesで確認する room_messagesはroom.indexだ
      # 16行目で@room_user.roomと.nameが爆誕しているので引数として後ろにつける
    end
  end

  context '投稿に成功したとき' do
    it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'message_content', with:post
      #テストという文字列を投稿フォームに入力すると仮定する
      #変数postに「テスト」という文字列を代入する
      #ここで変数に代入するのはこのあとの工程で再度この文字列を使用するから

      # 送信した値がDBに保存されていることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)

      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user)

      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to have_content(post)
      #一覧画面のなかに（page)変数postに格納されている文字列があるかどうかを確認している
   end
  

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')
      #作成したテスト用の画像のパスを生成している
      #Rails.rootとすると、このRailsアプリケーションのトップ階層のディレクトリまでの絶対パスを取得できる
      #パスの情報に対してjoinメソッドを利用することで、引数として渡した文字列でのパス情報を
      #Rails.rootのパスの情報につけることができる

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      # 送信した値がDBに保存されていることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Message.count }.by(1)    
      # 投稿一覧画面に遷移していることを確認する
      expect(current_path).to eq room_messages_path(@room_user)
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
   end
  

    it 'テキストと画像の投稿に成功すること' do
      # サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する
      click_on(@room_user.room.name)

      # 添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
      attach_file('message[image]', image_path, make_visible: true)
      # 値をテキストフォームに入力する
      post = "テスト"
      fill_in 'message_content', with:post
      # 送信した値がDBに保存されていることを確認する
      expect{find('input[name="commit"]').click}.to change { Message.count }.by(1)
      # 送信した値がブラウザに表示されていることを確認する
      expect(page).to  have_content(post)
      # 送信した画像がブラウザに表示されていることを確認する
      expect(page).to have_selector("img")
    end
  end
end