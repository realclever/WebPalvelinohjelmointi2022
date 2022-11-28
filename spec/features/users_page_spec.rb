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
      brewery = FactoryBot.create :brewery, name: 'test_brewery' 
      beer = FactoryBot.create :beer, name: 'test_beer', brewery: brewery 
      rating =  FactoryBot.create :rating, score: 1, beer: beer, user: user
      rating2 =  FactoryBot.create :rating, score: 3, beer: beer, user: user
    end

    it "shows users ratings" do
    sign_in(username: "Pekka", password: "Foobar1")
    expect(page).to have_content "Pekka\nHas made 2 ratings, average rating 2.0"
    end

    it "remove user rating(s)" do
      sign_in(username: "Pekka", password: "Foobar1")
      expect(page).to have_content "Pekka\nHas made 2 ratings, average rating 2.0"
      expect{
        page.all('a', text: 'Delete')[1].click 
      }.to change{Rating.count}.by(-1)
      expect(page).to have_content "Pekka\nHas made 1 rating, average rating 1"
  end
end