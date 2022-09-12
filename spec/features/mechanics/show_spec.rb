require 'rails_helper'

RSpec.describe 'As a user,' do
  describe 'When I visit the mechanics show page' do
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

      RideMechanic.create!(ride: @hurler, mechanic: @jimmy)
      RideMechanic.create!(ride: @scrambler, mechanic: @jimmy)
      RideMechanic.create!(ride: @ferris, mechanic: @jimmy)
      RideMechanic.create!(ride: @jaws, mechanic: @molly)
    end

    it "I see their name, years of experience, and the names of rides they are working on" do
      visit "/mechanics/#{@jimmy.id}"

      expect(page).to have_content(@jimmy.name)
      expect(page).to have_content("Years of Experience: #{@jimmy.years_experience}")
      # expect(page).to have_content(@ferris.name) not open
      expect(page).to have_content(@hurler.name)
      expect(page).to have_content(@scrambler.name)
      expect(page).not_to have_content(@jaws.name)
      expect(page).not_to have_content(@molly.name)
    end

    it "And I only see rides that are open" do
      visit "/mechanics/#{@jimmy.id}"

      expect(page).to_not have_content(@ferris.name)
    end

    xit "And the rides are listed by thrill rating in descending order" do
      visit "/mechanics/#{@jimmy.id}"
      # save_and_open_page
      # dealing with a shoulda matcher error here.

      expect("Hurler").to appear_before("Scrambler")
    end

    it "I see a form to add a ride to their workload" do
      visit "/mechanics/#{@jimmy.id}"

      expect(page).to have_content("Add Ride")
      expect(find('form')).to have_content('ID')
      expect(page).to have_button("submit")
    end

    context "When I fill in that field with an id of an existing ride and hit submit" do
      it "I’m taken back to that mechanic's show page, And I see the name of that newly added ride on this mechanics show page" do
        visit "/mechanics/#{@jimmy.id}"

        fill_in "ID", with: @jaws.id
        click_button "submit"

        expect(current_path).to eq("/mechanics/#{@jimmy.id}")
        expect(page).to have_content(@jaws.name)
      end
    end
  end
end
