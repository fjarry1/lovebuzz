class Conversation < ApplicationRecord
  belongs_to :match
  has_many :messages
  validates :match_id, uniqueness: true
end
