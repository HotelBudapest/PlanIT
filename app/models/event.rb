class Event < ApplicationRecord
  belongs_to :user
  has_many :polls, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, :description, :location, :start_time, :end_time, presence: true
end
