class User < ApplicationRecord
  include RatingAverage
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
end
