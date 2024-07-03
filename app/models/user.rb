class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id', dependent: :destroy
  has_many :event_users
  has_many :events, through: :event_users
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
