class RemindersController < ApplicationController
  before_action :set_application

  def create
    @reminder = @application.reminders.build(reminder_params)
    @reminder.creator = current_user
    authorize @reminder
    if @reminder.save
      redirect_to @application, notice: "Reminder set."
    else
      redirect_to @application, alert: "Could not set reminder: #{@reminder.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @reminder = @application.reminders.find(params[:id])
    authorize @reminder
    @reminder.destroy
    redirect_to @application, notice: "Reminder deleted."
  end

  private

  def set_application
    @application = Application.find(params[:application_id])
  end

  def reminder_params
    params.require(:reminder).permit(:message, :remind_at)
  end
end
