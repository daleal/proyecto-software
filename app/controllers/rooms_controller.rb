class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[create update destroy]

  def catalog
    @q = params[:q]

    if @q
      @rooms = Room.where(number: @q)

    else
      @rooms = Room.all
    end
  end

  def index
    @venue = Venue.find(params[:venue_id])

    @q = params[:q]

    if @q
      @rooms = Room.where(venue_id: params[:venue_id], number: @q)

    else
      @rooms = Room.where(venue_id: params[:venue_id])
    end

  end

  def show
    @room = Room.find(params[:id])
    @venue = Venue.find(@room.venue_id)
  end

  def new
    @venue = Venue.find(params[:venue_id])
    @room = Room.new
  end

  def create
    @venue = Venue.find(params[:venue_id])
    if current_user.administrator?
      @room = Room.new(room_params)
      if @room.save
        flash[:success] = "Se ha creado una sala llamada "\
                          "#{@room.number} correctamente!"
      else
        flash[:warning] = "No se ha podido crear la sala!"
      end
    end
    redirect_to venue_rooms_path(@venue)
  end

  def edit
    @room = Room.find(params[:id])
    @venue = Venue.find(@room.venue_id)
  end

  def update
    @room = Room.find(params[:id])
    @venue = Venue.find(@room.venue_id)
    if current_user.administrator?
      if @room.update_attributes(room_params)
        flash[:success] = "Se ha editado la sala llamada "\
                          "#{@room.number} correctamente."
      else
        flash[:warning] = "No se ha podido editar la sala."
      end
    end
    redirect_to venue_rooms_path(@venue)
  end

  def destroy
    @room = Room.find(params[:id])
    @venue = Venue.find(@room.venue_id)
    if current_user.administrator?
      @room.destroy
      flash[:success] = "Se ha eliminado una sala correctamente"
      redirect_to venue_rooms_path(@venue)
    end
  end

  private

  def room_params
    params.require(:room).permit(:number, :venue_id)
  end

  def access
    if params.key?(:venue_id)
      @venue = Venue.find(params[:venue_id])
    else
      @room = Room.find(params[:id])
      @venue = Venue.find(@room.venue_id)
    end
    unless current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to venue_rooms_path(@venue)
    end
  end

end
