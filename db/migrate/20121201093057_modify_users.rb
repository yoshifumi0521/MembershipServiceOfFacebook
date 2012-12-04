#Userモデルに、メールアドレスと暗唱番号のカラムを追加
class ModifyUsers < ActiveRecord::Migration
  def up
    
    add_column :users, :mailadress,:string #メールアドレス
    add_column :users, :imageurl, :string #Facebookのプロフィール画像 
    add_column :users, :paypalnumber ,:string #ペイパルの番号
  end

  def down
 
 
 
 
 
  end
end
