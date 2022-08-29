class Match < ApplicationRecord
  belongs_to :user_1_id, class_name: 'User'
  belongs_to :user_2_id, class_name: 'User'
  has_one :conversation
  validates_uniqueness_of :user_1_id, scope: [:user_2_id]
end
