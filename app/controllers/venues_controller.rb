class VenuesController < ApplicationController
  def index
    @venues = Venues.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = venue.new
  end

  def create
    @venue = Venue.new
    @venue.save
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
  end
end
