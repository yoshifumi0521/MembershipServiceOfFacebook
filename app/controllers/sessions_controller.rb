# coding: utf-8
#ログインやログアウトするコントローラー
class SessionsController < ApplicationController

  #oauth認証をするアクション。ここで、Facebookにリダイレクトする。
  def get
    
    #oauthクラスをつくるための変数
    @app_id = Settings.APPID
    @app_secret = Settings.APPSECRET
    @args = {:site => 'https://graph.facebook.com', :token_url => '/oauth/access_token', :ssl => { :verify => false } } 

    #OAuth2::Clientオブジェクトを取得
    @client = OAuth2::Client.new( @app_id ,@app_secret, @args)

    #Facebookからのコールバックurlを作成。
    @callback_url = url_for(:controller => "sessions",:action => "callback")
    
    #facebookにリダイレクトする。
    redirect_to @client.auth_code.authorize_url(:redirect_uri => @callback_url)

  end

  #Facebookからcallbackがきたらするアクション
  def callback
    logger.debug("callbackがきた"); 





  end










end
