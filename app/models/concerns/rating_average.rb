module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    (ratings.map { |b| b['score'] }.sum / ratings.count).to_f
  end
end
