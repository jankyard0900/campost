class GearReview < ApplicationRecord
  belongs_to :customer
  belongs_to :gear

  validates :rate, presence: true
  validates :title, presence: true
  validates :review, presence: true
end
