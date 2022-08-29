class BlockedUser < ApplicationRecord
  belongs_to :user_1_id, class_name: 'User'
  belongs_to :user_2_id, class_name: 'User'
end
