class Event < ApplicationRecord
  has_many :polls, dependent: :destroy
  has_many :poll_options, through: :polls
  accepts_nested_attributes_for :polls, allow_destroy: true

  belongs_to :creator, class_name: 'User'
  has_many :event_users, dependent: :destroy
  has_many :attendees, through: :event_users, source: :user

  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :location_link, format: { with: /\A(http|https):\/\/[a-zA-Z0-9\-.]+\.[a-z]{2,4}\/?\S*\z/, message: 'must be a valid URL' }, allow_blank: true
end
