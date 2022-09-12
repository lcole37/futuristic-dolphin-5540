require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  describe 'methods' do
    before :each do
      @jimmy = Mechanic.create!(name: "Jimmy", years_experience: 2)
      @mike = Mechanic.create!(name: "Mike", years_experience: 4)
      @molly = Mechanic.create!(name: "Molly", years_experience: 6)
    end

    describe 'average_experience' do
      it "returns average years of experience among mechanics" do
        @mechanics = Mechanic.all
        expect(@mechanics.average_experience).to eq(4)

        @Jane = Mechanic.create!(name: "Jane", years_experience: 8)
        @mechanics = Mechanic.all

        expect(@mechanics.average_experience).to eq(5)
      end
    end

    describe 'open rides' do
      before :each do
        @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

        @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 3, open: true)
        @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
        @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

        @jimmy = Mechanic.create!(name: "Jimmy", years_experience: 2)

        RideMechanic.create!(ride: @hurler, mechanic: @jimmy)
        RideMechanic.create!(ride: @scrambler, mechanic: @jimmy)
        RideMechanic.create!(ride: @ferris, mechanic: @jimmy)
      end

      it 'returns array of open rides in order of thrill' do
        expect(@jimmy.open_rides).to eq([@scrambler, @hurler])
      end
    end
  end
end
