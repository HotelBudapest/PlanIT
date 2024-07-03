class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_many :event_users, dependent: :destroy
  has_many :attendees, through: :event_users, source: :user

  has_one_attached :image

  validates :title, :description, :location, :start_time, :end_time, presence: true
end
