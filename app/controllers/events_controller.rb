class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def index
    @course = Course.find(params[:course_id])
    @events = Event.where(course_id: params[:course_id])
  end

  def show
    @event = Event.find(params[:id])
    @course = Course.find(@event.course_id)
  end

  def new
    @course = Course.find(params[:course_id])
    @event = Event.new
  end

  def create
    @course = Course.find(params[:course_id])
    @event = Event.new(event_params)
    @event.created_by = current_user.email
    if @event.save
      flash[:success] = "Se ha creado un evento del tipo "\
                        "#{@event.category} correctamente."
    else
      flash[:warning] = "No se ha podido crear el evento."
    end
    redirect_to course_events_path(@course)
  end

  def edit
    @event = Event.find(params[:id])
    @course = Course.find(@event.course_id)
  end

  def update
    @event = Event.find(params[:id])
    @course = Course.find(@event.course_id)
    if (@event.created_by == current_user.email) || \
       current_user.administrator?
      if @event.update_attributes(event_params)
        flash[:success] = "Se ha editado un evento del tipo "\
                          "#{@event.category} correctamente."
      else
        flash[:warning] = "No se ha podido editar el evento."
      end
    end
    redirect_to course_events_path(@course)
  end

  def destroy
    @event = Event.find(params[:id])
    @course = Course.find(@event.course_id)
    if (@event.created_by == current_user.email) || \
       current_user.administrator?
      @event.destroy
      flash[:success] = "Se ha eliminado el evento correctamente."
    end
    redirect_to course_events_path(@course)
  end

  private

  def event_params
    params.require(:event).permit(:category, :description, :course_id, :room_id, :venue_id)
  end

  def access
    if params.key?(:course_id)
      @course = Course.find(params[:course_id])
    else
      @event = Event.find(params[:id])
      @course = Course.find(@event.course_id)
    end
    unless (@event.created_by == current_user.email) || \
           current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to course_events_path(@course)
    end
  end

end
