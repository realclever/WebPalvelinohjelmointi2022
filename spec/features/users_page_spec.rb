require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "shows users zero ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    expect(page).to have_content "Pekka\nHas made 0 ratings, average rating 0"
  end
end

  describe "create settings" do 
    before :each do
      user = FactoryBot.create :user
      brewery = FactoryBot.create :brewery, name: "Beer factory" 
      brewery2 = FactoryBot.create :brewery, name: "Olut valmistaja"
      beer = FactoryBot.create :beer, name: "Iso olut", style: "Lager", brewery: brewery 
      beer2 = FactoryBot.create :beer, name: "Tosi iso olut", style: "IPA", brewery: brewery2
      rating =  FactoryBot.create :rating, user: user, score: 4, beer: beer
      rating2 =  FactoryBot.create :rating, user: user, score: 6, beer: beer2
      rating3 = FactoryBot.create :rating, user: user, score: 5, beer: beer
    end

    it "favorite brewery and style exists" do
      sign_in(username: "Pekka", password: "Foobar1")
      expect(page).to have_content "Favorite brewery Olut valmistaja"
      expect(page).to have_content "Favorite style IPA"
      #save_and_open_page
    end

    it "favorite brewery and style exists revisited" do
      sign_in(username: "Pekka", password: "Foobar1")
      expect(page).to have_content "Favorite brewery Olut valmistaja"
      expect(page).to have_content "Favorite style IPA"
      expect(page).to have_content "Pekka\nHas made 3 ratings, average rating 5.0"
      expect{
        page.all('a', text: 'Delete')[1].click 
      }.to change{Rating.count}.by(-1)
      expect(page).to have_content "Pekka\nHas made 2 ratings, average rating 4.0"
      expect(page).to have_content "Favorite brewery Beer factory"
      expect(page).to have_content "Favorite style Lager"
    end

    it "shows users ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    expect(page).to have_content "Pekka\nHas made 3 ratings, average rating 5.0"
    end

    it "remove user rating(s)" do
      sign_in(username: "Pekka", password: "Foobar1")
      expect(page).to have_content "Pekka\nHas made 3 ratings, average rating 5.0"
      expect{
        page.all('a', text: 'Delete')[1].click 
      }.to change{Rating.count}.by(-1)
      expect(page).to have_content "Pekka\nHas made 2 ratings, average rating 4.0"
  end
end