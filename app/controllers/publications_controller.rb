class PublicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @publications = Publication.all
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def new
    @publication = Publication.new
  end

  def create
    publication_data = publication_params
    publication_data[:publication_date] = Time.current
    @publication = Publication.new(publication_data)
    if @publication.save
      flash[:success] = "Se ha creado una publicación con el título "\
                        "#{@publication.title} correctamente!"
    else
      flash[:warning] = "No se ha podido crear la publicación!"
    end
    redirect_to publications_path
  end

  def edit
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    if @publication.update_attributes(publication_params)
      flash[:success] = "Se ha editado la publicación con el título "\
                        "#{@publication.title} correctamente!"
    else
      flash[:warning] = "No se ha podido editar la publicación!"
    end
    redirect_to publications_path
  end

  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy
    flash[:info] = "Se ha eliminado una publicación correctamente"
    redirect_to publications_path
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :description)
  end

end
