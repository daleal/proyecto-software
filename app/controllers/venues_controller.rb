class VenuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    respond_to do |format|
      if @venue.save
        format.html do
          redirect_to @venue, notice: "¡El campus ha sido "\
                                      "creado con éxito!"
        end
      end
    end
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    respond_to do |format|
      if @venue.update(venue_params)
        format.html do
          redirect_to @venue, notice: "¡El campus ha sido "\
                                      "editado con éxito!"
        end
      end
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    respond_to do |format|
      format.html do
        redirect_to venues_url, notice: "¡El campus ha sido "\
                                        "eliminado con éxito!"
      end
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address, :description)
  end

end
