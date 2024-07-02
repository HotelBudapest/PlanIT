class User < ApplicationRecord
  has_many :events
  has_many :votes
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
