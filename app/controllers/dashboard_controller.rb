class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @recent_applications = current_user.applications.order(created_at: :desc).limit(5)
    @application_count = current_user.applications.count
    @pending_applications = current_user.applications.where(status: [:applied, :interviewing, :screening]).count
    @accepted_applications = current_user.applications.where(status: :accepted).count
    @rejected_applications = current_user.applications.where(status: :rejected).count

    # Étapes à venir
    @upcoming_steps = ApplicationStep.joins(:application)
                                   .where(applications: { user_id: current_user.id })
                                   .where('next_action_date >= ?', Date.today)
                                   .where(completed: false)
                                   .order(next_action_date: :asc)
                                   .limit(5)

    # Stats sur les technologies les plus demandées
    @top_technologies = Technology.joins(job_technologies: { job_listing: :applications })
                                .where(applications: { user_id: current_user.id })
                                .group(:id)
                                .order('COUNT(technologies.id) DESC')
                                .limit(5)
                                .select('technologies.*, COUNT(technologies.id) as count')
  end
end
