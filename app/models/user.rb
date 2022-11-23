class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true,
                       length: { minimum: 3, maximum: 30 }
  validates :password, format: { with: /(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{4,}/, message: "must be at least 4 characters and include capital letter and one number." }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end
end
