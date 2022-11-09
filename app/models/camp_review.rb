class CampReview < ApplicationRecord
  belongs_to :customer
  belongs_to :camp

  validates :rate, presence: true
  validates :title, presence: true
  validates :review, presence: true
end
