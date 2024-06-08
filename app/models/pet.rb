class Pet < ApplicationRecord
  belongs_to :breed
  belongs_to :owner, optional: true

  validates :name, presence: true
  validates :weight, numericality: { greater_than: 0 }, allow_nil: true
end
