class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[create update destroy]

  def index
    @room = Room.find(params[:room_id])
    @courses = Course.where(room_id: params[:room_id])
  end

  def show
    @course = Course.find(params[:id])
    @room = Room.find(@course.room_id)
    moderator = ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    flash[:info] = "Vista de moderador." if @is_moderator
  end

  def new
    @room = Room.find(params[:room_id])
    @course = Course.new
  end

  def create
    @room = Room.find(params[:room_id])
    if current_user.administrator?
      @course = Course.new(course_params)
      if @course.save
        flash[:success] = "Se ha creado un ramo con el nombre "\
                          "#{@course.name} correctamente."
      else
        flash[:warning] = "No se ha podido crear el ramo."
      end
    end
    redirect_to room_courses_path(@room)
  end

  def edit
    @course = Course.find(params[:id])
    @room = Room.find(@course.room_id)
  end

  def update
    @course = Course.find(params[:id])
    @room = Room.find(@course.room_id)
    if current_user.administrator?
      @course = Course.find(params[:id])
      if @course.update_attributes(course_params)
        flash[:success] = "Se ha editado el ramo con el nombre "\
                          "#{@course.name} correctamente."
      else
        flash[:warning] = "No se ha podido editar ramos."
      end
    end
    redirect_to room_courses_path(@room)
  end

  def destroy
    @course = Course.find(params[:id])
    @room = Room.find(@course.room_id)
    if current_user.administrator?
      @course = Course.find(params[:id])
      @course.destroy
      flash[:success] = "Se ha eliminado el ramo correctamente."
    end
    redirect_to room_courses_path(@room)
  end

  private

  def course_params
    params.require(:course).permit(:name, :initials, :teacher_name, :room_id)
  end

  def access
    if params.key?(:room_id)
      @room = Room.find(params[:room_id])
    else
      @course = Course.find(params[:id])
      @room = Room.find(@course.room_id)
    end
    unless current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to room_courses_path(@room)
    end
  end

end
