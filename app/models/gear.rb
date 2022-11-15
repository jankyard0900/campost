class Gear < ApplicationRecord
  has_many_attached :gear_images

  belongs_to :customer
  belongs_to :category
  has_many :gear_reviews, dependent: :destroy

  validates :gear_images, presence: true
  validates :name,        presence: true, uniqueness: true
  validates :price,       presence: true

  scope :latest, -> {order(created_at: :desc)}
end
