class ApplicationStepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application
  before_action :set_application_step, only: [:update, :destroy]

  def create
    @application_step = @application.application_steps.build(application_step_params)

    if @application_step.save
      redirect_to @application, notice: 'Étape ajoutée avec succès.'
    else
      redirect_to @application, alert: 'Erreur lors de l\'ajout de l\'étape.'
    end
  end

  def update
    if @application_step.update(application_step_params)
      redirect_to @application, notice: 'Étape mise à jour avec succès.'
    else
      redirect_to @application, alert: 'Erreur lors de la mise à jour de l\'étape.'
    end
  end

  def destroy
    @application_step.destroy
    redirect_to @application, notice: 'Étape supprimée avec succès.'
  end

  private

  def set_application
    @application = current_user.applications.find(params[:application_id])
  end

  def set_application_step
    @application_step = @application.application_steps.find(params[:id])
  end

  def application_step_params
    params.require(:application_step).permit(:step_type, :date, :notes, :completed, :next_action_date)
  end
end
