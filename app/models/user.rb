#coding: utf-8
#Userのデータをしまう場所
class User < ActiveRecord::Base
  
  attr_accessible :name, :uid,:mailadress,:paypalnumber
  
  #バリデーションをつける。
  #FacebookIdは同じものは存在しない
  validates :uid, uniqueness: true
  
  #email情報は必須にする。
  validates :mailadress,presence: true







end
