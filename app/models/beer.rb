class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end

  def self.top(num)
    Beer.all.sort_by{ |b| -(b.average_rating || 0) }[0..num - 1]
  end
end
