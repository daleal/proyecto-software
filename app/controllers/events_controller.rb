class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

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
    @event.created_by = current_user.email
    @event.users.push(current_user)
    if @event.save
      flash[:success] = "Se ha creado un evento del tipo "\
                        "#{@event.category} correctamente."
    else
      flash[:warning] = "No se ha podido crear el evento."
    end
    redirect_to events_path
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if (@event.created_by == current_user.email) || \
       current_user.administrator?
      if @event.update_attributes(event_params)
        flash[:success] = "Se ha editado un evento del tipo "\
                          "#{@event.category} correctamente."
      else
        flash[:warning] = "No se ha podido editar el evento."
      end
    end
    redirect_to events_path
  end

  def destroy
    @event = Event.find(params[:id])
    if (@event.created_by == current_user.email) || \
       current_user.administrator?
      @event.destroy
      flash[:success] = "Se ha eliminado el evento correctamente."
    end
    redirect_to events_path
  end

  def join
    @event = Event.find_by_id(event)
    @event.users.push(current_user)
    redirect_to events_path
  end

  def leave
    @event = Event.find_by_id(34)
    @event.users.delete(current_user)
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:category, :description, :course_id, :room_id, :venue_id)
  end

  def access
    @event = Event.find(params[:id])
    unless (@event.created_by == current_user.email) || \
           current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to events_path
    end
  end

end
