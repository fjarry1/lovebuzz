class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :preference
  has_many :blocked_users
  validates :first_name, :last_name, :birthdate, :description, :gender, presence: true
  validates :description, length: { minimum: 100 }
  validate :old_enough?

  def old_enough?
    errors.add(:birthdate, "Vous devez avoir au moins 18 ans.") unless (DateTime.now - birthdate).to_i >= 6570
  end
end
