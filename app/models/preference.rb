class Preference < ApplicationRecord
  belongs_to :user
  validates :max_distance, :min_age, :max_age, numericality: { greater_than: 0 }
  validate :age_gap?

  def age_gap?
    errors.add(:max_age, "The upper age limit can't be lower than the min age limit") unless :max_age >= :min_age
  end
end
