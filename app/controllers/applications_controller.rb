class ApplicationsController < ApplicationController
  before_action :set_job, only: [:index, :new, :create]
  before_action :set_application, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @applications = policy_scope(Application)
    @applications = @applications.where(job: @job) if @job
    @applications = @applications.by_status(params[:status])
    @applications = @applications.recent
    authorize Application
  end

  def show
    authorize @application
  end

  def new
    @application = @job.applications.build
    authorize @application
  end

  def create
    @application = @job.applications.build(application_params)
    @application.user = current_user
    authorize @application
    if @application.save
      redirect_to @application, notice: "Application submitted successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @application
  end

  def update
    authorize @application
    if @application.update(application_params)
      redirect_to @application, notice: "Application updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @application
    @application.destroy
    redirect_to job_applications_path(@application.job), notice: "Application deleted."
  end

  def update_status
    authorize @application, :update?
    if @application.update(status: params[:status])
      redirect_back fallback_location: @application, notice: "Status updated to #{params[:status].humanize}."
    else
      redirect_back fallback_location: @application, alert: "Could not update status."
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id]) if params[:job_id]
  end

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:resume, :cover_letter)
  end
end
