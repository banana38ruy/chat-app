class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
      #この記述によりログインしていないユーザーをログインページへ吹っ飛ばす 
  before_action :configure_permitted_parameters, if: :devise_controller?
      #ifというオプションを使用している点に注目
      #これは、値にメソッド名を指定することで、その戻り値がtrueで合ったときのみ処理を実行するよう設定するものなのです
  private
       #GEM内の記述は直接編集できないのでdevise_prameter_sanitizerを使う！
        #devise_parameter_sanitizer.parmit(:dviseの処理名, keys: [許可するキー])を記述する
  def configure_permitted_parameters
        #慣習でつける名前
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      #devise処理名は
       # :sign_in | サインイン（ログイン）の処理を行う時
       # :sign_up | サインアップ(新規登録)の処理を行う時
        # :account_update | アカウント情報更新の処理を行う時
        # keyにフォームで入力されたnameが情報として足されsign_upの箱にはいり、その箱が上に送られジャッジされる
  end
end