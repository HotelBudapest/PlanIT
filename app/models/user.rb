class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id', dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable  
end
