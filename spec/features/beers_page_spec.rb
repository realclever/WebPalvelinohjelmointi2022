require 'rails_helper'

include Helpers

describe "adding new beer" do
    before :each do
    FactoryBot.create :brewery, name: "Brewery", year: 2022
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
    end

    it "it with proper name"  do
        visit new_beer_path
        fill_in('beer_name', with: 'test_beer')
        expect{
            click_button "Create Beer"
          }.to change{Beer.count}.from(0).to(1)
        expect(page).to have_content 'Beer was successfully created.'  
        expect(page).to have_content 'test_beer'
    end

    it "it without a proper name"  do
        visit new_beer_path
        fill_in('beer_name', with: '')
        click_button "Create Beer"
        expect(page).to have_content '1 error prohibited this beer from being saved:'
        expect(page).to have_content 'Name can\'t be blank'
        expect(Beer.count).to eq(0)
    end

end    