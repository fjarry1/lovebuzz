class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]
  has_one :preference
  has_many :blocked_users, dependent: :destroy
  # has_many :matches, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_one :preference, dependent: :destroy
  has_many :blocked_users, foreign_key: :user_1_id, class_name: 'BlockedUser', dependent: :destroy
  has_many :blocked_users, foreign_key: :user_2_id, class_name: 'BlockedUser', dependent: :destroy
  # has_many :matches, dependent: :destroy
  has_many_attached :photos
  validates :first_name, :last_name, :birthdate, :description, :gender, presence: true
  validates :description, length: { minimum: 100 }
  # validate :old_enough?

  scope :available, -> { where(availability: true) } #permet de filtrer les user available
  scope :unavailable, -> { where(availability: false) }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  before_destroy :destroy_all_matches

  # def old_enough?
    # errors.add(:birthdate, "Vous devez avoir au moins 18 ans.") unless (DateTime.now - birthdate).to_i >= 6570
  # end


  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def all_matches
    sql = "user_1_id = :user_id OR user_2_id = :user_id"
    Match.where(sql, user_id: self.id)
  end

  def destroy_all_matches
    all_matches.each(&:destroy)
  end

  def age
    age = DateTime.now.year - birthdate.year
    age -= 1 if DateTime.now < birthdate + age.years
    return age

  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
