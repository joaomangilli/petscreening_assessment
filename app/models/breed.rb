class Breed < ApplicationRecord
  has_many :pets, dependent: :restrict_with_error

  validates :name, :description, :life_min, :life_max, :male_weight_min,
    :male_weight_max, :female_weight_min, :female_weight_max, presence: true

  validates :name, uniqueness: true
end
