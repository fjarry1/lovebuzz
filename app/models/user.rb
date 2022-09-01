class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:spotify]
  has_one :preference
  has_many :blocked_users
  has_many :all_matches
  has_many :messages, dependent: :destroy

  has_one :preference, dependent: :destroy
  has_many :blocked_users, foreign_key: :user_1_id, class_name: 'BlockedUser', dependent: :destroy
  has_many :blocked_users, foreign_key: :user_2_id, class_name: 'BlockedUser', dependent: :destroy
  has_many :matches, dependent: :destroy
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


  def currently_playing
    # url = "me/player/currently-playing"
    response = RSpotify.resolve_auth_request(@user.id, url)
    return response if RSpotify.raw_response

    Track.new response["item"]
    
  def age
    age = DateTime.now.year - birthdate.year
    age -= 1 if DateTime.now < birthdate + age.years
    return age

  end
end
