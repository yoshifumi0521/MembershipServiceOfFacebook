# coding: utf-8
#ログインやログアウトするコントローラー
class SessionsController < ApplicationController

  #applicationコントローラーのauthorizeメソッドは実行しないようにする。
  skip_before_filter :authorize
   
  #oauth認証をするアクション。ここで、Facebookにリダイレクトする。
  def get
    
    #リダイレクトurlを取得する。
    @redirect_url = GetObject("get",nil)
    #facebookにリダイレクトする。
    redirect_to @redirect_url 

  end

  #Facebookからcallbackがきたらするアクション
  def callback
    
    #アクセストークンのオブジェクトを取得。これをUserコントローラーのnewに渡したいかも。
    @access_token = GetObject("callback",params[:code]) 


    






    
    #ユーザーのデータを取得して、@user_data変数に格納する。
    #@user_data = @access_token.get("/me/").parsed
    #Userモデルのデータベースの中に、ユーザーのデータがあるかどうかを調べる。なかったら、新しいデータをつくる。
    #@user = User.find_or_initialize_by_uid(@user_data["id"])

    #if @user.new_record?
      #新規ユーザーだった場合の処理。
    #  logger.debug("新規ユーザーの場合")
      #ユーザーの名前をいれる。
    #  @user.name = @user_data["name"]
      #ユーザーのプロフィール写真のurlをいれる。
   #   @user.imageurl = "http://graph.facebook.com/" + @user_data["id"] + "/picture"
      #ユーザーのメールアドレスをいれる。
   #   @user.mailadress = @user_data["email"]

      #ここでUserコントローラーのnewアクションにリダイレクトする。ユーザーデータはまだ保存しない。
      #けど、ここでレンダリングしていいのか、ちょっと怖いかも。
   #   redirect_to :controller => "users",:action => "index"

   # elsif !@user.new_record?
      #新規ユーザーではない場合のの処理。
   #   logger.debug("新規ユーザーの場合ではない。")

      #クッキーに、@userのidをいれる。クッキーの期限を30日にする。
   #   cookies.signed[:user_id] ={ value: @user.id ,expires: 30.days.from_now }
      #home画面にリダイレクトする。
   #   redirect_to :root
      #ここで処理をやめる。
   #   return
    
   # end





    
  end

  #ログアウトするときのメソッド
  def logout
    
    #クッキーを削除する。
    cookies.delete :user_id
    #ホームにリダイレクトする。
    redirect_to :root

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
      #メールアドレスを取得するために、スコープに"email"をいれる。
      return @client.auth_code.authorize_url(:redirect_uri => @callback_url,:scope => "email")
    elsif pattern == "callback"
      #フォーマットを決める。
      @header_format = 'OAuth %s'
      return @client.auth_code.get_token(param, {:redirect_uri => @callback_url,
        :parse => :query} ,{:header_format => @header_format})
    end

  end
 















end
