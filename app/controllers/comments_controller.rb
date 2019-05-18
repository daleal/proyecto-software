class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def index
    @publication = Publication.find(params[:publication_id])
    @comments = Comment.where(publication_id: params[:publication_id])
  end

  def show
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.find(params[:id])
  end

  def new
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.new
  end

  def create
    comment_data = comment_params
    comment_data[:comment_date] = Time.current
    comment_data[:created_by] = current_user.email
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.new(comment_data)
    if @comment.save
      flash[:success] = "Se ha creado el comentario correctamente."
    else
      flash[:warning] = "No se ha podido crear el comentario."
    end
    redirect_to publication_comments_path
  end

  def edit
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if (@comment.created_by == current_user.email) || \
       current_user.administrator?
      if @comment.update_attributes(comment_params)
        flash[:success] = "Se ha editado el comentario correctamente."
      else
        flash[:warning] = "No se ha podido editar el comentario."
      end
    end
    redirect_to publication_comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if (@comment.created_by == current_user.email) || \
       current_user.administrator?
      @comment.destroy
      flash[:warning] = "Se ha eliminado en comentario correctamente."
    end
    redirect_to publication_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def access
    @comment = Comment.find(params[:id])
    unless (@comment.created_by == current_user.email) || \
           current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to publication_comments_path
    end
  end

end
