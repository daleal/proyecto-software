class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Se ha creado un evento del tipo "\
                        "#{@event.category} correctamente!"
    else
      flash[:warning] = "No se ha podido crear el evento!"
    end
    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Se ha editado un evento del tipo "\
                        "#{@event.category} correctamente!"
    else
      flash[:warning] = "No se ha podido editar el evento!"
    end
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:info] = "Se ha eliminado un evento correctamente"
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:category, :description)
  end

end
