class Gear < ApplicationRecord
  belongs_to :customer
  belongs_to :category
  has_many :gear_reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
end
