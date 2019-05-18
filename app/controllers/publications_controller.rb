class PublicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :access, only: %i[update destroy]

  def index
    @event = Event.find(params[:event_id])
    @publications = Publication.where(event_id: params[:event_id])
  end

  def show
    @event = Event.find(params[:event_id])
    @publication = Publication.find(params[:id])
  end

  def new
    @event = Event.find(params[:event_id])
    @publication = Publication.new
  end

  def create
    publication_data = publication_params
    publication_data[:publication_date] = Time.current
    publication_data[:created_by] = current_user.email
    @event = Event.find(params[:event_id])
    @publication = Publication.new(publication_data)

    if @publication.save
      flash[:success] = "Se ha creado una publicación con el título "\
                        "#{@publication.title} correctamente."
    else
      flash[:warning] = "No se ha podido crear la publicación."
    end

    redirect_to publications_path
  end

  def edit
    @event = Event.find(params[:event_id])
    @publication = Publication.find(params[:id])
  end

  def update
    @publication = Publication.find(params[:id])
    if (@publication.created_by == current_user.email) || \
       current_user.administrator?
      if @publication.update_attributes(publication_params)
        flash[:success] = "Se ha editado la publicación con el título "\
                          "#{@publication.title} correctamente."
      else
        flash[:warning] = "No se ha podido editar la publicación."
      end
    end
    redirect_to publications_path
  end

  def destroy
    @publication = Publication.find(params[:id])
    if (@publication.created_by == current_user.email) || \
       current_user.administrator?
      @publication.destroy
      flash[:success] = "Se ha eliminado la publicación correctamente."
    end
    redirect_to publications_path
  end

  private

  def publication_params
    params.require(:publication).permit(:title, :description)
  end

  def access
    @publication = Publication.find(params[:id])
    unless (@publication.created_by == current_user.email) || \
           current_user.administrator?
      flash[:warning] = "No tienes permiso para ejecutar esta acción."
      redirect_to publications_path
    end
  end

end
