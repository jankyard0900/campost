class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :camps,        dependent: :destroy
  has_many :camp_reviews, dependent: :destroy
  has_many :gears,        dependent: :destroy
  has_many :gear_reviews, dependent: :destroy

  validates :name, presence: true, length: { minimum: 1, maximum: 10 },
    format: {with:/\A[ぁ-んァ-ン一-龥]/,message: "は、ひらがな、カタカナ、漢字のどれかで入力して下さい"}

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲストユーザー"
    end
  end
end
