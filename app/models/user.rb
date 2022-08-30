class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :matches,
            ->(user) {
              unscope(where: :user_id)
              .where("user_1_id = :user_id OR user_2_id = :user_id", user_id: user.id)
            },
            class_name: 'Match',
            dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one :preference, dependent: :destroy
  has_many :blocked_users, foreign_key: :user_1_id, class_name: 'BlockedUser', dependent: :destroy
  has_many :blocked_users, foreign_key: :user_2_id, class_name: 'BlockedUser', dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many_attached :photos
  validates :first_name, :last_name, :birthdate, :description, :gender, presence: true
  validates :description, length: { minimum: 100 }
  validate :old_enough?

  def old_enough?
    errors.add(:birthdate, "Vous devez avoir au moins 18 ans.") unless (DateTime.now - birthdate).to_i >= 6570
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
