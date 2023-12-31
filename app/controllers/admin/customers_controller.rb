class Admin::CustomersController < ApplicationController
# 　before_action :authenticate_admin!
#   before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @reported_count = Report.where(reported_customer_id: @customer.id).count
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "登録情報の変更が完了しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end
  
  def destroy
   customer = Customer.find(params[:id])
   customer.destroy
   redirect_to admin_customers_path
  end 

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :nickname, :email, :is_active, :member_type, :customer_status)
  end

end
