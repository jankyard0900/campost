class CampReview < ApplicationRecord
  has_many_attached :review_camp_images
  
  belongs_to :customer
  belongs_to :camp

  validates :rate, presence: true
  validates :title, presence: true
  validates :review, presence: true
end
