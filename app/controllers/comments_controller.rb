class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    comment_data = comment_params
    comment_data[:comment_date] = Time.current
    @comment = Comment.new(comment_data)
    if @comment.save
      flash[:success] = "Se ha creado un comentario correctamente!"
    else
      flash[:warning] = "No se ha podido crear el comentario!"
    end
    redirect_to comments_path
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = "Se ha editado el comentario correctamente!"
    else
      flash[:warning] = "No se ha podido editar el comentario!"
    end
    redirect_to comments_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:info] = "Se ha eliminado un comentario correctamente"
    redirect_to comments_path
  end

  private

    def comment_params
      data = params.require(:comment).permit(:content)
    end
end
