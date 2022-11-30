require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple locations are returned by the API, they areshown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Beer place", id: 1 ),
        Place.new( name: "Beer place II", id: 2 ) ]
    )
    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content "Beer place"
    expect(page).to have_content "Beer place II"
    #save_and_open_page
  end

  it "if zero localations is returned by the API, there will be an error" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      []
    )
    visit places_path
    fill_in("city", with: "kumpula")
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
    #save_and_open_page
  end








end