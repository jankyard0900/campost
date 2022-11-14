class GearReview < ApplicationRecord
  has_many_attached :review_gear_images

  belongs_to :customer
  belongs_to :gear

  validates :rate, presence: true
  validates :title, presence: true
  validates :review, presence: true
end
