class CompaniesController < ApplicationController
  before_action :set_company, only: %i[show update destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    paginate json: @companies

end

# GET /companies/1
# GET /companies/1.json
  def show
    @companies = Company.find(params[:id])
    @companies.punch(request)
    company_info = @companies.attributes
    company_info[:count] = @companies.hits
    render json: company_info
  end

  def parish
    @companies = Company.distinct.pluck(:parish)
    render json: @companies
  end

# POST /companies
# POST /companies.json
  def create
    @company = Company.new(company_params)
  
    if @company.save
      render :show, status: :created, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

# PATCH/PUT /companies/1
# PATCH/PUT /companies/1.json
  def update
    if @company.update(company_params)
      render :show, status: :ok, location: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

# DELETE /companies/1
# DELETE /companies/1.json
  def destroy
    @company.destroy
  end

private

# Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:id])
  end

# Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :contact, :address, :parish, :postalCode)
  end

end
