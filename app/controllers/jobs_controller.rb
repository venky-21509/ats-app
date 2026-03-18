class JobsController < ApplicationController
    before_action :set_company, only: [:index, :new, :create]
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def index
    @jobs = policy_scope(Job)
    @jobs = @company ? @jobs.where(company: @company) : @jobs
    @jobs = @jobs.recent
  end

  def show
    authorize @job
  end

  def new
    @job = @company.jobs.build
    authorize @job
  end

  def create
    @job = @company.jobs.build(job_params)
    @job.creator = current_user
    authorize @job
    if @job.save
      redirect_to @job, notice: "Job posted successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @job
  end

  def update
    authorize @job
    if @job.update(job_params)
      redirect_to @job, notice: "Job updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @job
    @job.destroy
    redirect_to company_jobs_path(@job.company), notice: "Job deleted."
  end

  private

  def set_company
    @company = Company.find(params[:company_id]) if params[:company_id]
  end

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :location, :job_type, :status, :closes_at)
  end
end
