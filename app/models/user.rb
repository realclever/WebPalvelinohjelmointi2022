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

  def favorite_brewery
    return nil if ratings.empty?

    breweries_averages = []
    ratings.group_by { |b| b.beer.brewery.name }.each do |brewery, ratings|
      breweries_averages << { brewery:, rating: (ratings.map(&:score).sum / ratings.count.to_f) }
    end
    breweries_averages.min_by{ |b| -b[:rating] }[:brewery]
  end

  def favorite_style
    return nil if ratings.empty?

    styles_averages = []
    ratings.group_by { |s| s.beer.style }.each do |style, ratings|
      styles_averages << { style:, rating: (ratings.map(&:score).sum / ratings.count.to_f) }
    end
    styles_averages.min_by{ |s| -s[:rating] }[:style]
  end

  def self.top(num)
    User.all.sort_by{ |b| -(b.average_rating || 0) }[0..num - 1]
  end
end
