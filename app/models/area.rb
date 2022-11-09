class Area < ApplicationRecord
  has_many :camps

  validatable :name, presence: true, uniqueness: true
end
