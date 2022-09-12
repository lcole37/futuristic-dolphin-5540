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
  end
end
