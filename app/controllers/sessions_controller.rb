# coding: utf-8
#ログインやログアウトするコントローラー
class SessionsController < ApplicationController

  #oauth認証をするアクション。ここで、Facebookにリダイレクトする。
  def get

    #リダイレクトurlを取得する。
    @redirect_url = GetObject("get",nil)

    #facebookにリダイレクトする。
    redirect_to @redirect_url 

  end

  #Facebookからcallbackがきたらするアクション
  def callback

    #アクセストークンのオブジェクトを取得
    @access_token = GetObject("callback",params[:code]) 

    #ユーザーのデータを取得して、@user_data変数に格納する。
    @user_data = @access_token.get("/me/").parsed

    #Userモデルのデータベースの中に、ユーザーのデータがあるかどうかを調べる。なかったら、新しいデータをつくる。
    @user = User.find_or_initialize_by_uid_and_name(@user_data["id"],@user_data["name"])

    #新規ユーザーではない場合
    if !@user.new_record?
      #クッキーに、@userのidをいれる。クッキーの期限を30日にする。
      cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now }

      #home画面にリダイレクトする。
      redirect_to :root
      
      #ここで処理をやめる。
      return
    end
    
    #新規ユーザー場合、ここで何らかの処理をおこなうのか？




    
    #データが保存されたらする処理。
    if @user.save
      #クッキーに、@userのidをいれる。クッキーの期限を30日にする。
      cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now }
      
      #ホーム画面に戻る。
      redirect_to :root
      return 
    elsif
      #ホーム画面に戻る。
      redirect_to :root
      return
    end
      

  end






  #何らかのオブジェクトを返すメソッド。いろいろなoauthオブジェクトなど内部で作成
  def GetObject(pattern,param)
    
    #oauthクラスをつくるための変数
    @app_id = Settings.APPID
    @app_secret = Settings.APPSECRET 
    @args = {:site => 'https://graph.facebook.com', :token_url => '/oauth/access_token', :ssl => { :verify => false } }

    #OAuth2::Clientオブジェクトを取得
    @client = OAuth2::Client.new( @app_id ,@app_secret, @args) 
    
    @callback_url = url_for(:controller => "sessions",:action => "callback")

    if pattern == "get"
      
      return @client.auth_code.authorize_url(:redirect_uri => @callback_url)
    
    elsif pattern == "callback"

      #フォーマットを決める。
      @header_format = 'OAuth %s'
      return @client.auth_code.get_token(param, {:redirect_uri => @callback_url,
        :parse => :query} ,{:header_format => @header_format})

    end

  end
 
















end
