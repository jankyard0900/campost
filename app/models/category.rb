class Category < ApplicationRecord
  has_many :gears

  validatable :name, presence: true, uniqueness: true
end
