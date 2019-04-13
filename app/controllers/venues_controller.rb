class VenuesController < ApplicationController
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
      if @venue.save:
        format.html { redirect_to @venue, notice: '¡El campus ha sido creado con éxito!'}
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
        format.html { redirect_to @venue, notice: '¡El campus ha sido editado con éxito!' }
      end
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    respond_to do |format|
      format.html { redirect_to venues_url, notice: '¡El campus ha sido eliminado con éxito!'}
    end
  end

  private

    def venue_params
      params.require(:venue).permit(:name, :address, :description)
    end
end
