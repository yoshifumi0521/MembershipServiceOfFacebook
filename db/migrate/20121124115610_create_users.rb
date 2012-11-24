class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid,null:false #FacebookのIDをいれる
      t.string :name,null: false #名前をいれる。

      t.timestamps

    end
    
    #データベースに、uidとnameとの複合一意制約をつける。uidとnameで同じものはみとめない。
    add_index(:users, [:uid, :name], :unique => true)  
 
  end
end
