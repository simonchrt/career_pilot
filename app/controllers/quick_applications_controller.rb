class QuickApplicationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @quick_application = {
      company: Company.new,
      job_listing: JobListing.new,
      application: Application.new
    }
    @companies = Company.all.order(name: :asc)
    @technologies = Technology.all.order(name: :asc)
  end

  def create
    ActiveRecord::Base.transaction do
      # Gestion de l'entreprise
      if params[:use_existing_company] == "1" && params[:company_id].present?
        company = Company.find(params[:company_id])
      else
        company = Company.create!(company_params)
      end

      # Création de l'offre d'emploi
      job_listing = JobListing.new(job_listing_params)
      job_listing.company = company
      job_listing.save!

      # Ajout des technologies
      if params[:technology_ids].present?
        params[:technology_ids].each do |technology_id|
          job_listing.job_technologies.create!(technology_id: technology_id)
        end
      end

      # Création de la candidature
      application = current_user.applications.new(application_params)
      application.job_listing = job_listing
      application.save!

      # Créer l'étape initiale si une date de candidature est fournie
      if application.applied_date.present?
        application.application_steps.create!(
          step_type: 'application_sent',
          date: DateTime.now,
          notes: 'Candidature envoyée',
          completed: true
        )
      end

      redirect_to application_path(application), notice: 'Candidature créée avec succès!'
    end

  rescue ActiveRecord::RecordInvalid => e
    @quick_application = {
      company: params[:use_existing_company] == "1" ? Company.find(params[:company_id]) : Company.new(company_params),
      job_listing: JobListing.new(job_listing_params),
      application: Application.new(application_params)
    }
    @companies = Company.all.order(name: :asc)
    @technologies = Technology.all.order(name: :asc)
    flash.now[:alert] = "Erreur lors de la création: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  private

  def company_params
    params.require(:company).permit(:name, :website, :industry, :location, :size, :notes)
  end

  def job_listing_params
    params.require(:job_listing).permit(
      :title, :description, :url, :remote,
      :salary_min, :salary_max, :currency, :contract_type
    )
  end

  def application_params
    params.require(:application).permit(
      :status, :applied_date, :notes, :priority
    )
  end
end
