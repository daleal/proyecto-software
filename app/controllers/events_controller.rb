class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def catalog
    @q = params[:q]
    
    if @q
      @events = Event.where(category: @q), + Course.where(description: @q)
    else
      @events = Event.all
    end
  end

  def index
    @course = Course.find(params[:course_id])
    @q = params[:q]

    if @q
      @events = Event.where(course_id: params[:course_id], category: @q), + Course.where(course_id: params[:course_id], description: @q)
    else
      @events = Event.where(course_id: params[:course_id])
    end

    moderator = ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    flash[:info] = "Vista de moderador." if @is_moderator
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
    @event.users.push(current_user)
    @event.created_by = current_user.id
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
    if @event.update_attributes(event_params)
      flash[:success] = "Se ha editado un evento del tipo "\
                        "#{@event.category} correctamente."
    else
      flash[:warning] = "No se ha podido editar el evento."
    end
    redirect_to course_events_path(@course)
  end

  def destroy
    @event = Event.find(params[:id])
    @course = Course.find(@event.course_id)
    @event.destroy
    flash[:success] = "Se ha eliminado el evento correctamente."
    redirect_to course_events_path(@course)
  end

  def join
    @event = Event.find(params[:event_id])
    @course = Course.find(@event.course_id)
    @event.users.push(current_user)
    if @event.save
      flash[:success] = "Te has unido al evento "\
                        "#{@event.category} correctamente."
    else
      flash[:warning] = "No te has podido unir evento."
    end
    redirect_to course_events_path(@course)
  end

  def leave
    @event = Event.find(params[:event_id])
    @course = Course.find(@event.course_id)
    @event.users.delete(current_user)
    if @event.save
      flash[:success] = "Has dejado el evento "\
                        "#{@event.category} correctamente."
    else
      flash[:warning] = "No has podido dejar evento."
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

    moderator = ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    unless current_user.administrator? || @is_moderator
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to course_events_path(@course)
    end
  end

end
