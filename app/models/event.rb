class Event < ApplicationRecord
  has_many :polls, dependent: :destroy
  has_many :poll_options, through: :polls
  accepts_nested_attributes_for :polls, allow_destroy: true

  belongs_to :creator, class_name: 'User'
  has_many :event_users
  has_many :attendees, through: :event_users, source: :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_one_attached :image
end
