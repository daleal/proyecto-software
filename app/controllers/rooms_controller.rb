class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = "Se ha creado una sala llamada #{@room.letter}"\
                        "#{@room.number} correctamente!"
    else
      flash[:warning] = "No se ha podido crear la sala!"
    end
    redirect_to rooms_path
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update_attributes(room_params)
      flash[:success] = "Se ha editado la sala llamada #{@room.letter}"\
                        "#{@room.number} correctamente!"
    else
      flash[:warning] = "No se ha podido editar la sala!"
    end
    redirect_to rooms_path
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:info] = "Se ha eliminado una sala correctamente"
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:number)
  end

end
