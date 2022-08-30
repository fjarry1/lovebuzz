class Match < ApplicationRecord
  belongs_to :user_1_id, class_name: 'User'
  belongs_to :user_2_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :user_1_id, scope: [:user_2_id]

  def interlocutor_of(user)
    user == user_1_id ? user_2_id : first_user
  end
end
