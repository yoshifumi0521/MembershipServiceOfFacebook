#coding: utf-8
#Userのデータをしまう場所
class User < ActiveRecord::Base
  
  attr_accessible :name, :uid
  
  #バリデーションをつける。
  #FacebookIdは同じものは存在しない
  validates :uid, uniqueness: true
    







end
