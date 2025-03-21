class TechnologiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_technology, only: [:edit, :update, :destroy]

  def index
    @technologies = Technology.all.order(name: :asc)
  end

  def new
    @technology = Technology.new
  end

  def create
    @technology = Technology.new(technology_params)

    if @technology.save
      redirect_to technologies_path, notice: 'Technologie créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @technology.update(technology_params)
      redirect_to technologies_path, notice: 'Technologie mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @technology.job_technologies.exists?
      redirect_to technologies_path, alert: 'Cette technologie est utilisée par des offres d\'emploi et ne peut pas être supprimée.'
    else
      @technology.destroy
      redirect_to technologies_path, notice: 'Technologie supprimée avec succès.'
    end
  end

  private

  def set_technology
    @technology = Technology.find(params[:id])
  end

  def technology_params
    params.require(:technology).permit(:name, :category)
  end
end
