class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def index
    @q = params[:q]
    if @q
      @venues = Venue.includes_substring("name", @q)
    else
      @venues = Venue.all
    end
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    if current_user.administrator?
      @venue = Venue.new(venue_params)
      if @venue.save
        flash[:success] = "Se ha creado un campus con el nombre "\
                          "#{@venue.name} correctamente."
      else
        flash[:warning] = "No se ha podido crear el campus."
      end
    end
    redirect_to venues_path
  end

  def edit
    @venue = Venue.find(params[:id])
  end

  def update
    if current_user.administrator?
      @venue = Venue.find(params[:id])
      if @venue.update_attributes(venue_params)
        flash[:success] = "Se ha editado el campus con el nombre "\
                          "#{@venue.name} correctamente."
      else
        flash[:warning] = "No se ha podido editar el campus."
      end
    end
    redirect_to venues_path
  end

  def destroy
    if current_user.administrator?
      @venue = Venue.find(params[:id])
      @venue.destroy
      flash[:success] = "Se ha eliminado el campus correctamente."
    end
    redirect_to venues_path
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :address, :description)
  end

  def access
    unless current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to venues_path
    end
  end

end
