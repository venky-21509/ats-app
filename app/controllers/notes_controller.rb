class NotesController < ApplicationController
  before_action :set_application

  def create
    @note = @application.notes.build(note_params)
    @note.author = current_user
    authorize @note
    if @note.save
      redirect_to @application, notice: "Note added."
    else
      redirect_to @application, alert: "Could not add note: #{@note.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @note = @application.notes.find(params[:id])
    authorize @note
    @note.destroy
    redirect_to @application, notice: "Note deleted."
  end

  private

  def set_application
    @application = Application.find(params[:application_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end