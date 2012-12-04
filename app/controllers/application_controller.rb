#coding: utf-8
#一番上のApplicationコントローラー
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  private
  #すべてのコントローラーのアクションの実行時にこの処理を行う。
  def authorize
    
    if cookies.signed[:user_id]
      
      #ログインユーザーのオブジェクトを@current_user変数にいれる。
      @current_user = User.find_by_id(cookies.signed[:user_id])
      #クッキー情報があったとしても、ユーザー情報がなくてnilだったら、クッキーを削除する。 
      cookies.delete :user_id unless @current_user
   
      #stepがnilだったら、登録編集画面に強制的にいかせる。
      if !@current_user.step  
        redirect_to "/users/"+ @current_user.id.to_s + "/edit"
      end

   end

  end








end
