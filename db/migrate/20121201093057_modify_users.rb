#Userモデルに、メールアドレスと暗唱番号のカラムを追加
class ModifyUsers < ActiveRecord::Migration
  def up
    
    add_column :users, :mailadress,:string #メールアドレス
     

  end

  def down
 
 
 
 
 
  end
end
