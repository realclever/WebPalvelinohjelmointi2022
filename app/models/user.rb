class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, format: { with: /(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{4,}/, message: "must be at least 4 characters and include capital letter and one number." }
end
