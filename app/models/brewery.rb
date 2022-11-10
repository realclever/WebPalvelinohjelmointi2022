class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validate :brewery_validation
  # validates :year, numericality: { only_integer: true, greater_than_or_equal_to: 1040, less_than_or_equal_to: 2022 }

  def brewery_validation
    return unless (year.present? && year < 1040) || year > Date.today.year

    errors.add(:year, "must be between 1040 and present year")
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
