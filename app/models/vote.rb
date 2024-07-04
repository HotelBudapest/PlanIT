class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :poll_option
  belongs_to :user

  validates :poll, presence: true
  validates :poll_option, presence: true
  validates :user, presence: true
end
