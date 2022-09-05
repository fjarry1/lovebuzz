class Match < ApplicationRecord
  belongs_to :user_1, foreign_key: :user_1_id, class_name: 'User'
  belongs_to :user_2, foreign_key: :user_2_id, class_name: 'User'
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :user_1_id, scope: [:user_2_id]

  scope :matched, -> { where(status: 'Favorable') }

  def interlocutor_of(user)
    user == user_1 ? user_2 : user_1
  end
end
