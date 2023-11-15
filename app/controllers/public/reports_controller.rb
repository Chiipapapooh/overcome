class Public::ReportsController < ApplicationController
  def new
    @report = Report.new
    @customer = Customer.find(params[:customer_id])
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @report = Report.new(report_params)
    @report.reporter_id = current_customer.id
    @report.reported_id = @customer.id

    if @report.save
      redirect_to profile_customers_path(@customer)
    else
      render "new"
    end
  end 
end
