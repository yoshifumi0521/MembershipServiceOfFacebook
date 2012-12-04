# coding: utf-8
#Userコントローラー
class UsersController < ApplicationController

  #applicationコントローラーのauthorizeメソッドは実行しないようにする。
  skip_before_filter :authorize,only: [:edit ,:update]

  def index
  
  
  end

  def new
         
  
  
  end

  def create

  
  end

  def show
  
  
  
  end

  #新規ユーザーと、編集登録で決定を押さなかった人が通る。
  def edit
  
    #Userモデルから、idと一致するものを選ぶ。
    @user = User.find(cookies.signed[:user_id])

    if !@user
      #ここでエラー処理。

    end

  end

  def update

    @user = User.find(params[:id])
    #ハッシュとして@userにいれる。
    @user.attributes = params[:user]

    logger.debug(@user)

    #ステップを変える
    @user.step = 1
    #ペイパルの番号が書かれてたらステップを3にする。
    if @user.paypalnumber
      @user.step = 2
    end

    if @user.save
      #ホームに戻す。
      redirect_to :root
    else
      #もう一度editアクションに戻す。
      render "edit"
    end


  
  
  end

  def destroy
  
  
  
  end




end
