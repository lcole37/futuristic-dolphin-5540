class MechanicsController < ApplicationController
  def index
    @mechanics = Mechanic.all
  end

  def show
    @mechanic = Mechanic.find(params[:id])
  end

  def create
    require "pry"; binding.pry
    ride = Ride.find(params[:id])
    RideMechanic.create(ride: ride, mechanic: @mechanic)
    render show
  end
end
