class Conversation < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy
  validates :match_id, uniqueness: true
end
