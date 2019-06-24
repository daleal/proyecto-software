class ModeratorRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def index
    @course = Course.find(params[:course_id])
    @moderator_requests = ModeratorRequest.where(course_id: params[:course_id])
    moderator = ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    flash[:info] = "Vista de moderador." if @is_moderator
  end

  def new
    @course = Course.find(params[:course_id])
    @moderator_request = ModeratorRequest.new
  end

  def create
    moderator_request_data = moderator_request_params
    moderator_request_data[:user_id] = current_user.id
    @course = Course.find(params[:course_id])
    if ModeratorRequest.where(course_id: @course.id, user_id: current_user.id).first.nil?
      @moderator_request = @course.moderator_requests.new(moderator_request_data)
      if @moderator_request.save
        flash[:success] = "Se ha creado la solicitud correctamente."
      else
        flash[:warning] = "No se ha podido crear la solicitud."
      end
    else
      flash[:warning] = "Ya tienes una solicitud creada para este curso."
    end
    redirect_to course_moderator_requests_path(@course)
  end

  def edit
    @moderator_request = ModeratorRequest.find(params[:id])
    @course = Course.find(@moderator_request.course_id)
  end

  def update
    @moderator_request = ModeratorRequest.find(params[:id])
    @course = Course.find(@moderator_request.course_id)
    if @moderator_request.update_attributes(moderator_request_params)
      flash[:success] = "Se ha respondido a la solicitud correctamente."
    else
      flash[:warning] = "No se ha podido responder a la solicitud."
    end
    redirect_to course_moderator_requests_path(@course)
  end

  def destroy
    @moderator_request = ModeratorRequest.find(params[:id])
    @course = Course.find(@moderator_request.course_id)
    @moderator_request.destroy
    flash[:warning] = "Se ha eliminado en comentario correctamente."
    redirect_to course_moderator_requests_path(@course)
  end

  private

  def moderator_request_params
    params.require(:moderator_request).permit(:content, :status)
  end

  def access
    @moderator_request = ModeratorRequest.find(params[:id])

    moderator = ModeratorRequest.where(course_id: params[:course_id], user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    unless (@moderator_request.user_id == current_user.id) || \
           current_user.administrator? || @is_moderator
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to course_moderator_requests_path(@course)
    end
  end

end
