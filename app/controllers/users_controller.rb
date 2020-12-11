class UsersController < ApplicationController
  #ユーザー編集でやるアクションを定義する
  def edit 
  end

  def update
    # 現在のユーザーをアップデートする(下から送られてきたデータによって)
    # if文で保存できた場合とできなかった場合の条件分岐処理を行う
    # redirect_to はルーティングからコントローラー通ってビューに表示されるおもてなし経路
    # render はビューに直帰させる ぶぶ漬け経路
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end  
  end
  
  private
  #更新するユーザーのデータ（nameとemailを）をuserにつめこんで
  #上のアップデートに放り投げる
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
