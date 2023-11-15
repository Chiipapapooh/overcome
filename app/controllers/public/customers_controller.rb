class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer
  
  def index
    @customers = Customer.all
  end
  
  def show
    if params[:id].nil?
      @customer = current_customer
    else
      @customer = Customer.find(params[:id])
    end 
    
    if @customer == current_customer
       @posts = current_customer.posts
    else
       @posts = @customer.posts.where(is_draft: false)
    end 
  end
  

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
  def liked_posts
  @liked_posts = Post.liked_posts(current_customer, params[:page], 12)
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :nickname, :email, :is_active, :member_type)
  end
end
