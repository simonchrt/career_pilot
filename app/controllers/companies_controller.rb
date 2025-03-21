class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all.order(name: :asc)
  end

  def show
    @job_listings = @company.job_listings
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to @company, notice: 'Entreprise créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: 'Entreprise mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @company.job_listings.exists?
      redirect_to companies_url, alert: 'Cette entreprise ne peut pas être supprimée car elle a des offres d\'emploi associées.'
    else
      @company.destroy
      redirect_to companies_url, notice: 'Entreprise supprimée avec succès.'
    end
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :website, :industry, :location, :size, :notes, :logo)
  end
end
