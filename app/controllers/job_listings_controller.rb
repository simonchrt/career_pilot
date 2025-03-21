class JobListingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy]

  def index
    @job_listings = JobListing.includes(:company, :technologies).order(created_at: :desc)
  end

  def show
    @company = @job_listing.company
    @technologies = @job_listing.technologies
  end

  def new
    @job_listing = JobListing.new
    @companies = Company.all.order(name: :asc)
    @technologies = Technology.all.order(name: :asc)
  end

  def create
    @job_listing = JobListing.new(job_listing_params)

    if @job_listing.save
      # Gérer les technologies
      if params[:technology_ids].present?
        params[:technology_ids].each do |technology_id|
          @job_listing.job_technologies.create(technology_id: technology_id)
        end
      end

      redirect_to @job_listing, notice: 'Offre d\'emploi créée avec succès.'
    else
      @companies = Company.all.order(name: :asc)
      @technologies = Technology.all.order(name: :asc)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @companies = Company.all.order(name: :asc)
    @technologies = Technology.all.order(name: :asc)
  end

  def update
    if @job_listing.update(job_listing_params)
      # Mettre à jour les technologies
      @job_listing.job_technologies.destroy_all
      if params[:technology_ids].present?
        params[:technology_ids].each do |technology_id|
          @job_listing.job_technologies.create(technology_id: technology_id)
        end
      end

      redirect_to @job_listing, notice: 'Offre d\'emploi mise à jour avec succès.'
    else
      @companies = Company.all.order(name: :asc)
      @technologies = Technology.all.order(name: :asc)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job_listing.destroy
    redirect_to job_listings_url, notice: 'Offre d\'emploi supprimée avec succès.'
  end

  private

  def set_job_listing
    @job_listing = JobListing.find(params[:id])
  end

  def job_listing_params
    params.require(:job_listing).permit(
      :title, :description, :url, :company_id, :remote,
      :salary_min, :salary_max, :currency, :contract_type
    )
  end
end
