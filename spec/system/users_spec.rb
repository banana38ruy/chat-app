require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページに遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    #current_pathはに今アクセスしているページの情報が含まれている
    #expect(x).to eq Yメソッドによって current_path(現在のページ) は new_user_session_path（サインインページ） となることを確認している
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)
    #データベースにcreateメソッドでユーザーをテスト用のDBに保存する
    #この保存したユーザーで、このあとのログインを行っていく

    # サインインページへ移動する
    visit new_user_session_path
    #作成したユーザーがサインインページへ訪れる

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    #現在のページはサインインページとおなじになっているよ

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email',with: @user.email
    fill_in 'user_password',with: @user.password 
    #保存したユーザーのメルアドとパスワードをfill_inメソッドで入力を行う

    # ログインボタンをクリックする
    click_on("Log in")
    # click_onメソッドは引数に文字列を取り、一致するテキストなどを持った要素をクリックできる
    #  ""で囲った文字列のテキストリンク、もしくはその名前のvalue属性の値を持ったbutton要素をクリックする動作を再現できる

    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path

  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
      @user = FactoryBot.create(:user)
    # トップページに遷移する
      visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq new_user_session_path
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: "hanage"
    fill_in 'user_password', with: "77777"
    #左が記録のemailとpassword右が実際に入力して間違えてるパスワード

    # ログインボタンをクリックする
    click_on("Log in")
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq new_user_session_path
  end
end