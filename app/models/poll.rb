class Poll < ApplicationRecord
  belongs_to :event
  has_many :poll_options, dependent: :destroy
  accepts_nested_attributes_for :poll_options, allow_destroy: true

  has_many :votes, through: :poll_options
end
