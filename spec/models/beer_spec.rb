require 'rails_helper'

RSpec.describe Beer, type: :model do
    describe "with brewery" do
      let(:testbrewery) { Brewery.new name: "Oluen ystävät", year: 2022 }
  
      it "is saved with proper name, brewery and style" do
        beer = Beer.create name: "testbeer", style: "teststyle", brewery: testbrewery

        expect(beer).to be_valid
        expect(Beer.count).to eq(1)
      end

      it "is not saved without a proper name" do
        beer = Beer.create style: "teststyle", brewery: testbrewery

        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
      end

      it "is not saved without a proper style" do
        beer = Beer.create name: "testbeer", brewery: testbrewery

        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
        #????!
      end
    end
end