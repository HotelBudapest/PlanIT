class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(10)
  end
end
