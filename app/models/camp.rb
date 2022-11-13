class Camp < ApplicationRecord
  has_many_attached :camp_images

  belongs_to :area
  belongs_to :customer
  has_many :camp_reviews, dependent: :destroy

  validates :camp_images,        presence: true
  validates :name,               presence: true, uniqueness: true
  validates :address,            presence: true
  validates :access_method,      presence: true
  validates :parking,            presence: true
  validates :vehicle,            presence: true
  validates :close_facilities,   presence: true
  validates :hot_spring,         presence: true
  validates :in_site_facilities, presence: true
  validates :fee_information,    presence: true
end
