class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only: [:show, :edit, :update, :destroy]

  def index
    @applications = current_user.applications.includes(job_listing: :company)

    # Filtrage
    if params[:status].present?
      @applications = @applications.where(status: params[:status])
    end

    # Tri
    case params[:sort]
    when 'date'
      @applications = @applications.order(applied_date: :desc)
    when 'company'
      @applications = @applications.joins(job_listing: :company).order('companies.name ASC')
    when 'priority'
      @applications = @applications.order(priority: :asc)
    else
      @applications = @applications.order(created_at: :desc)
    end
  end

  def show
    @job_listing = @application.job_listing
    @company = @job_listing.company
    @application_steps = @application.application_steps.order(date: :desc)
    @new_step = @application.application_steps.build
  end

  def new
    @job_listing = JobListing.find(params[:job_listing_id])
    @application = current_user.applications.build(job_listing: @job_listing)
  end

  def create
    @application = current_user.applications.build(application_params)

    if @application.save
      # Créer l'étape initiale de candidature
      if @application.applied_date.present?
        @application.application_steps.create(
          step_type: 'application_sent',
          date: DateTime.now,
          notes: 'Candidature envoyée',
          completed: true
        )
      end

      redirect_to @application, notice: 'Candidature créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @application.update(application_params)
      redirect_to @application, notice: 'Candidature mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @application.destroy
    redirect_to applications_url, notice: 'Candidature supprimée avec succès.'
  end

  private

  def set_application
    @application = current_user.applications.find(params[:id])
  end

  def application_params
    params.require(:application).permit(
      :status, :job_listing_id, :applied_date,
      :response_date, :interview_date, :notes, :priority
    )
  end
end
