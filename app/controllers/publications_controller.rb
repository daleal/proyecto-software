class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]
  before_action :set_publication, only: %i[upvote downvote]

  helper_method :upvote
  helper_method :downvote

  def index
    @course = Course.find(params[:course_id])
    @publications = Publication.where(course_id: params[:course_id])
  end

  def show
    @publication = Publication.find(params[:id])
    @course = Course.find(@publication.course_id)
  end

  def new
    @course = Course.find(params[:course_id])
    @publication = Publication.new
  end

  def create
    @course = Course.find(params[:course_id])
    publication_data = publication_params
    publication_data[:publication_date] = Time.current
    publication_data[:created_by] = current_user.email
    publication_data[:course_id] = params[:course_id]
    @publication = Publication.new(publication_data)
    if @publication.save
      flash[:success] = "Se ha creado una publicación con el título "\
                        "#{@publication.title} correctamente."
    else
      flash[:warning] = "No se ha podido crear la publicación."
    end

    redirect_to course_publications_path(@course)
  end

  def edit
    @publication = Publication.find(params[:id])
    @course = Course.find(@publication.course_id)
  end

  def update
    @publication = Publication.find(params[:id])
    @course = Course.find(@publication.course_id)
    if (@publication.created_by == current_user.email) || \
       current_user.administrator?
      if @publication.update_attributes(publication_params)
        flash[:success] = "Se ha editado la publicación con el título "\
                          "#{@publication.title} correctamente."
      else
        flash[:warning] = "No se ha podido editar la publicación."
      end
    end
    redirect_to course_publications_path(@course)
  end

  def destroy
    @publication = Publication.find(params[:id])
    @course = Course.find(@publication.course_id)
    if (@publication.created_by == current_user.email) || \
       current_user.administrator?
      @publication.destroy
      flash[:success] = "Se ha eliminado la publicación correctamente."
    end
    redirect_to course_publications_path(@course)
  end

  # from user
  def upvote
    @publication.upvote_from current_user
    redirect_to course_publications_path(@course)
  end

  # from user
  def downvote
    @publication.downvote_from current_user
    redirect_to course_publications_path(@course)
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
    @course = Course.find(@publication.course_id)
  end

  def publication_params
    params.require(:publication).permit(:title, :description)
  end

  def access
    if params.key?(:course_id)
      @course = Course.find(params[:course_id])
    else
      @publication = Publication.find(params[:id])
      @course = Course.find(@publication.course_id)
    end
    unless (@publication.created_by == current_user.email) || \
           current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to course_publications_path(@course)
    end
  end

end
