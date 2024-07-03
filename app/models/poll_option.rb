class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :votes, dependent: :destroy
end
