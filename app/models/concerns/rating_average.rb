module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return 0 if ratings.count.zero?

    (ratings.map { |b| b['score'] }.sum / ratings.count).to_f
  end
end
