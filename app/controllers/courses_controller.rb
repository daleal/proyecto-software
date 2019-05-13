class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Se ha creado un ramo con el nombre "\
                        "#{@course.name} correctamente!"
    else
      flash[:warning] = "No se ha podido crear el ramo!"
    end
    redirect_to courses_path
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      flash[:success] = "Se ha editado el ramo con el nombre "\
                        "#{@course.name} correctamente!"
    else
      flash[:warning] = "No se ha podido editar el ramo!"
    end
    redirect_to courses_path
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:info] = "Se ha eliminado un ramo correctamente"
    redirect_to courses_path
  end

  private

  def course_params
    params.require(:course).permit(:name, :initials, :teacher_name)
  end

end
