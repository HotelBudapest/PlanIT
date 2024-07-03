class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :event_users
  has_many :attendees, through: :event_users, source: :user
  has_many :polls, dependent: :destroy
  has_one_attached :image

  accepts_nested_attributes_for :polls, allow_destroy: true
end
