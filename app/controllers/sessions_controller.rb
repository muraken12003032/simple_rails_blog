class SessionsController < ApplicationController
  
  # ログインページ
  def index
    render 'new'
  end
  
  # ログインの認証と成功した場合はセッション作成
  def create
    user = User.find_by_name params[:name]
    if user && user.authenticate(params[:pass])
      session[:user_id] = user.id
      redirect_to myblogadmin_blogs_path
    else
      flash.now.alert = "Invalid"
      render 'new'
    end
  end
  
  # ログアウト処理
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
