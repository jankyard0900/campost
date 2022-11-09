class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :camps,        dependent: :destroy
  has_many :camp_reviews, dependent: :destroy
  has_many :gears,        dependent: :destroy
  has_many :gear_reviews, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 10 },
    format: {with:/\A[ぁ-んァ-ン一-龥]/,message: "は、ひらがな、カタカナ、漢字のどれかで入力して下さい"}
end
