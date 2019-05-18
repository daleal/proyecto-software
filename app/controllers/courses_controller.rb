class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[create update destroy]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    moderator = ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    if @is_moderator
      flash[:info] = "¡Eres MODERADOR de este ramo!"
    end
  end

  def new
    @course = Course.new
  end

  def create
    if current_user.administrator?
      @course = Course.new(course_params)
      if @course.save
        flash[:success] = "Se ha creado un ramo con el nombre "\
                          "#{@course.name} correctamente."
      else
        flash[:warning] = "No se ha podido crear el ramo."
      end
    end
    redirect_to courses_path
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    if current_user.administrator?
      @course = Course.find(params[:id])
      if @course.update_attributes(course_params)
        flash[:success] = "Se ha editado el ramo con el nombre "\
                          "#{@course.name} correctamente."
      else
        flash[:warning] = "No se ha podido editar ramos."
      end
    end
    redirect_to courses_path
  end

  def destroy
    if current_user.administrator?
      @course = Course.find(params[:id])
      @course.destroy
      flash[:success] = "Se ha eliminado el ramo correctamente."
    end
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :initials, :teacher_name, :venue_id)
  end

  def access
    unless current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to courses_path
    end
  end

end
