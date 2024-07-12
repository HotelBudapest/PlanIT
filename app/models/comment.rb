class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :content, presence: true
  attribute :pinned, :boolean, default: false
end
