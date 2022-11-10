class Area < ApplicationRecord
  has_many :camps

  validates :name, presence: true, uniqueness: true
end
