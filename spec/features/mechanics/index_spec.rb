require 'rails_helper'

RSpec.describe 'As a user,' do
  describe 'When I visit the mechanics index page' do
    before :each do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

      @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

      @jimmy = Mechanic.create!(name: "Jimmy", years_experience: 2)
      @mike = Mechanic.create!(name: "Mike", years_experience: 4)
      @molly = Mechanic.create!(name: "Molly", years_experience: 6)

      visit "/mechanics" #I put visit in the "before" as this describe says "when I visit ___"
    end

    it 'I see a header saying “All Mechanics”' do
      expect(page).to have_content("All Mechanics")
      #is there a way to test that it is header/first on page?
    end

    it 'And I see a list of all mechanic’s names and their years of experience' do
      #within blocks could be used, but time
      expect(page).to have_content(@jimmy.name)
      expect(page).to have_content(@mike.name)
      expect(page).to have_content(@molly.name)
      expect(page).to have_content("Years of Experience: #{@jimmy.years_experience}")
      expect(page).to have_content("Years of Experience: #{@mike.years_experience}")
      expect(page).to have_content("Years of Experience: #{@molly.years_experience}")
    end

    it 'And I see the average years of experience across all mechanics' do
      expect(page).to have_content("Average Years of Experience: 4")
    end
  end
end
