class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]
  before_action :set_comment, only: %i[upvote downvote]

  helper_method :upvote
  helper_method :downvote

  def index
    @publication = Publication.find(params[:publication_id])
    @comments = Comment.where(publication_id: params[:publication_id])
    moderator = ModeratorRequest.where(course_id: @publication.course_id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    flash[:info] = "Vista de moderador." if @is_moderator
  end

  def show
    @comment = Comment.find(params[:id])
    @publication = Publication.find(@comment.publication_id)
  end

  def new
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.new
  end

  def create
    comment_data = comment_params
    comment_data[:comment_date] = Time.current
    comment_data[:created_by] = current_user.id
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.new(comment_data)
    if @comment.save
      flash[:success] = "Se ha creado el comentario correctamente."
    else
      flash[:warning] = "No se ha podido crear el comentario."
    end
    redirect_to publication_comments_path(@publication)
  end

  def edit
    @comment = Comment.find(params[:id])
    @publication = Publication.find(@comment.publication_id)
  end

  def update
    @comment = Comment.find(params[:id])
    @publication = Publication.find(@comment.publication_id)
    if @comment.update_attributes(comment_params)
      flash[:success] = "Se ha editado el comentario correctamente."
    else
      flash[:warning] = "No se ha podido editar el comentario."
    end
    redirect_to publication_comments_path(@publication)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @publication = Publication.find(@comment.publication_id)
    @comment.destroy
    flash[:success] = "Se ha eliminado el comentario correctamente."
    redirect_to publication_comments_path(@publication)
  end

  # from user
  def upvote
    @comment.upvote_from current_user
    redirect_to publication_comments_path(@publication)
  end

  # from user
  def downvote
    @comment.downvote_from current_user
    redirect_to publication_comments_path(@publication)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
    @publication = Publication.find(@comment.publication_id)
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def access
    if params.key?(:publication_id)
      @publication = Publication.find(params[:publication_id])
    else
      @comment = Comment.find(params[:id])
      @publication = Publication.find(@comment.publication_id)
    end

    moderator = ModeratorRequest.where(course_id: @publication.course_id, user_id: current_user.id).first
    @is_moderator = !moderator.nil? && moderator.accepted?
    unless (@publication.created_by == current_user.id) || \
           current_user.administrator? || @is_moderator
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to publication_comments_path(@publication)
    end
  end

end
