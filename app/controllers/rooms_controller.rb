class RoomsController < ApplicationController
      #コントローラーを作ったら
      #defでnewメソッド発動
      #@roomを定義する
      #form_withにわたす引数として、値が空のRoomインスタンスを
      #@roomに代入している
  def new
     @room = Room.new #Room爆誕
  end


end
