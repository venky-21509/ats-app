class CompaniesController < ApplicationController

before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = policy_scope(Company).order(:name)
  end

  def show; end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to @company, notice: "Company created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(company_params)
      redirect_to @company, notice: "Company updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to companies_path, notice: "Company deleted."
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :industry, :website, :description)
  end

end
