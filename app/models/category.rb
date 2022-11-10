class Category < ApplicationRecord
  has_many :gears

  validates :name, presence: true, uniqueness: true
end
