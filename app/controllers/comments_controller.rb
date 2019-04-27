class CommentsController < ApplicationController
  def index
    @publication = Publication.find(params[:publication_id])
    @comments = Comment.where(:publication_id => params[:publication_id])
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
    @publication = Publication.find(params[:publication_id])
    @comment = @publication.comments.new(comment_data)
    if @comment.save
      flash[:success] = "Se ha creado un comentario correctamente!"
    else
      flash[:warning] = "No se ha podido crear el comentario!"
    end
    redirect_to publication_comments_path
  end

  def edit
    @publication = Publication.find(params[:publication_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Se ha editado el comentario correctamente!"
    else
      flash[:warning] = "No se ha podido editar el comentario!"
    end
    redirect_to publication_comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:info] = "Se ha eliminado un comentario correctamente"
    redirect_to publication_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
