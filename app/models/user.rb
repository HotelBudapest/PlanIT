class User < ApplicationRecord
  has_many :created_events, class_name: 'Event', foreign_key: 'creator_id', dependent: :destroy
  has_many :event_users, dependent: :destroy
  has_many :events, through: :event_users, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  phony_normalize :phone_number, default_country_code: 'US'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, phony_plausible: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
