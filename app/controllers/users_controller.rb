class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @posts = @user.posts
    # ダイレクトメッセージの記述
    
      @currentRoomUser = RoomUser.where(user_id: current_user.id) #current_userがすでにルームに参加しているか判断
      @receiveUser = RoomUser.where(user_id: @user.id) #@userがルームに参加しているか判断
      unless @user.id == current_user.id  #current_userとユーザーが同一人物でなければ
        @currentRoomUser.each do |cu| #current_userが参加している全てのルームidを出力
         @receiveUser.each do |u| #@userが参加している全てのルームidを出力
            if cu.room_id == u.room_id #current_userのルームidと@userのルームidで一致するものがあるのか判断
              @haveRoom = true #既にルームがあるよという意味
              @roomId = cu.room_id #current_userが参加しているルームidを変数に代入
            end
          end
        end
        unless @haveRoom #ルームがなかったら
          @room = Room.new
          @RoomUser = RoomUser.new
        end
      end
    
    # //ダイレクトメッセージの記述
  end

end
