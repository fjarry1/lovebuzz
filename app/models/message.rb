class Message < ApplicationRecord
  belongs_to :match
  belong_to :user
  validates :content, presence: true
end
