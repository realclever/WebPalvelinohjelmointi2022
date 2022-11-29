require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "is not saved with too short password" do
    user = User.create username: "Pekka", password: "Pe0", password_confirmation: "Pe0"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "favorite beer, style and brewery" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

  it "has method for determining the favorite_beer" do
    expect(user).to respond_to(:favorite_beer)
    end

    it "has method for determining the favorite_brewery" do
      user = FactoryBot.create(:user)
      expect(user).to respond_to(:favorite_brewery)
    end  

    it "has method for determining the favorite_style" do
      user = FactoryBot.create(:user)
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have a favorite brewery" do
      user = FactoryBot.create(:user)
      expect(user.favorite_brewery).to eq(nil)
    end

    it "without ratings does not have a favorite style" do
      user = FactoryBot.create(:user)
      expect(user.favorite_style).to eq(nil)
    end    
  
    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
    
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end
end

def create_beer_with_rating(object, score)
  beer = FactoryBot.create(:beer)
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end

