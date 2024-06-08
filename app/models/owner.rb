class Owner < ApplicationRecord
  has_many :pets, dependent: :restrict_with_error

  validates :name, presence: true
end
